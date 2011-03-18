MIXPANEL_TOKEN = "7750721e6adc71d7d7f716d2b3795066"
Cappiello::Application.config.middleware.use "MixpanelMiddleware", MIXPANEL_TOKEN, :async => true