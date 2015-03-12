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
Header = require 'components/header'
Home = require 'components/home'
Work = require 'components/work'

# Moduel global functions and variables
pages = ['home', 'work', 'endorsements']
currPage = undefined
transitionDirection = ''

SetTransitionDirection = (pageName) ->
	if currPage and pageName in pages
		lastIdx = pages.indexOf currPage
		currIdx = pages.indexOf pageName

		transitionDirection = 'left' if lastIdx < currIdx
		transitionDirection = 'right' if lastIdx > currIdx
		transitionDirection = '' if lastIdx is currIdx

Root = React.createClass
	displayName: 'Root'
	mixins: [SyncState, Router.State]
	stores:
		site: SiteStore

	render: ->
		console.log 'render', @state
		# Determine page-slide transition direction
		name = @getRoutes().reverse()[0].name
		SetTransitionDirection name
		currPage = name
		
		<div id="Root" className={transitionDirection}>
			<Header />
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