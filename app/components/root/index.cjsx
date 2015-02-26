# @cjsx React.DOM
'use strict'

# Stores
SiteConst = require 'components/site/const'
SiteActions = require 'components/site/actions'
SiteStore = require 'components/site/store'

# Helpers and utilities
SyncState = require 'util/mixins/syncstate'

# Routing
Router = window.ReactRouter
{ DefaultRoute, Link, Route, RouteHandler, Redirect } = Router
TransitionGroup = React.addons.CSSTransitionGroup

# Child views
Home = require 'components/home'
Work = require 'components/work'

pages = ['home', 'work', 'endorsements']
currPage = undefined
transitionDirection = ''

Root = React.createClass
	displayName: 'Root'
	mixins: [SyncState, Router.State]
	stores:
		site: SiteStore

	render: ->
		console.log 'render', @state
		name = @getRoutes().reverse()[0].name

		# Determine page-slide transition direction
		if currPage and name in pages
			lastIdx = pages.indexOf currPage
			currIdx = pages.indexOf name

			transitionDirection = 'left' if lastIdx < currIdx
			transitionDirection = 'right' if lastIdx > currIdx
			transitionDirection = '' if lastIdx is currIdx
		currPage = name
		
		<div id="Root" className={transitionDirection}>
			<header id="Header"></header>
			<TransitionGroup transitionName="page">
				<RouteHandler key={name} params={{site: @state.site}} />
			</TransitionGroup>
		</div>

	componentDidMount: ->
		SiteActions.call null, SiteConst.SET_HEADER_HEIGHT, document.getElementById('Header').getBoundingClientRect().height
	

# Route Definitions
routes = (
	<Route name="app" path="/" handler={Root} >
		<Route name="home" handler={Home} />
		<Route name="work" handler={Work} />
		<Redirect from="/" to="home" />
	</Route>
)
Router.run routes, (Handler) ->
	React.render <Handler />, document.getElementById('Site-Container')

# Successfully required in
module.exports = true