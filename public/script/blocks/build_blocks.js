({
    baseUrl: ".",
    paths: {
        jquery:     "libs/jquery",
        underscore: "libs/underscore",
        backbone:   "libs/backbone",
        text:       "libs/text",
        v_mApp:     "views/v_mApp"

    },

    out: "_build/app_build.js",

    include: ["app","v_mApp"],
    wrap: true,
    /*
    modules: [ {  //name: "v_mApp" "app" }],
    */
    mainConfigFile: 'app.js',
    preserveLicenseComments: false,
  
})