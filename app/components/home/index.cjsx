# @cjsx React.DOM
'use strict'

Home = React.createClass
	displayName: 'Home'

	render: ->
		# console.log 'render Home: ', @props
		styles = {}
		hH = @props.params.site.header_height
		styles['padding-top'] = if hH then hH else 0

		<div className="home page" style={styles}>
			<div className="contents">
				Home Page
			</div>
		</div>

module.exports = Home