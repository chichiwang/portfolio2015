# @cjsx React.DOM
'use strict'

Work = React.createClass
	displayName: 'Work'

	render: ->
		# console.log 'render Home: ', @props
		styles = {}
		hH = @props.params.site.header_height
		styles['padding-top'] = if hH then hH else 0

		<div className="work page" style={styles}>
			Work Page
		</div>

module.exports = Work