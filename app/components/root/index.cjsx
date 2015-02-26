# @cjsx React.DOM
'use strict'

# Stores
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

Root = React.createClass
	displayName: 'Root'
	mixins: [SyncState, Router.State]
	stores:
		site: SiteStore

	render: ->
		console.log 'render', @state
		name = @getRoutes().reverse()[0].name
		
		<div id="Root">
			<TransitionGroup transitionName="page">
				<RouteHandler key={name} className="test" />
			</TransitionGroup>
		</div>

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