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
			<div className="contents">
				Work Page
			</div>
		</div>

module.exports = Work