# @cjsx React.DOM
'use strict'

Home = React.createClass
	displayName: 'Home'

	render: ->
		# console.log 'render Home: ', @props
		<div className="home page">
			Home Page
		</div>

module.exports = Home