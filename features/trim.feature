Feature: Interface with the tr.im API
	As a user
	I want to be able to interface with the tr.im API
	So that I can shorten URLs
	
	Scenario: Shorten URL
		Given I want to shorten "http://google.com"
		Then the URL should look like "http://tr.im/szkO"