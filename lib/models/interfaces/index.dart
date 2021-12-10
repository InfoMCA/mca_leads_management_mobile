const String reportData = '''{
  "categories": [
    "Does the vehicle start?",
    "Odometer picture",
    "Odometer value",
    "Does the car have bad odor?",
    "Sunroof or convertible top operational?",
    "Entertainment System Operational",
    "Upholstery or seat damage?",
    "How many keys?",
    "Keyless start?",
    "Navigation system?",
    "All windows operational?",
    "Steering wheel",
    "Entertainment System",
    "OBD",
    "Front seats",
    "Rear seats",
    "Flaws 1",
    "Flaws 2",
    "Flaws 3",
    "Flaws 4",
    "Under hood",
    "Front (Hood down)",
    "Front",
    "Front right",
    "Driver door",
    "Rear driver side door",
    "Back right",
    "Trunk",
    "Rear",
    "Left rear",
    "Rear passenger door",
    "Front passenger door",
    "Front right",
    "Roof",
    "Under car",
    "Hood",
    "Front left fender",
    "Driver door",
    "Rear driver door",
    "Back left fender",
    "Rear/Trunk",
    "Back right fender",
    "Rear passenger door",
    "Front passenger door",
    "Roof",
    "Front right fender",
    "Front left tread",
    "Back left tread",
    "Back right tread",
    "Front right tread",
    "Is there road rash under the front fender?",
    "Damage to front or rear lights?",
    "Have the bolts on the fender and/or hood been turned or chipped?",
    "Rust anywhere?",
    "All door handles/latches working?",
    "Frame/structural Damage?",
    "How many dents?",
    "How many scratches?",
    "Any chips or cracks in windshields?",
    "Driver License",
    "Title",
    "Registration"
  ],
  "reportItems": [
    {
      "name": "Does the vehicle start?",
      "placeholder": "",
      "questionFormat": "HorizontalSwitch",
      "items": [
        "Yes",
        "W/jump",
        "No-inop"
      ],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "Yes",
      "comments": null
    },
    {
      "name": "Odometer picture",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/8F4960F4-9C95-4ACD-929D-B14C6CB864A6/tmp/image_picker_D78ED305-6B0F-4B32-93F7-6C4B2E715F84-1512-000006628A993EB5.jpg",
      "comments": null
    },
    {
      "name": "Odometer value",
      "placeholder": "",
      "questionFormat": "NumberField",
      "items": [],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "12200",
      "comments": null
    },
    {
      "name": "Does the car have bad odor?",
      "placeholder": "",
      "questionFormat": "HorizontalSwitch",
      "items": [
        "No",
        "Yes",
        "Smoked-in"
      ],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "No",
      "comments": null
    },
    {
      "name": "Sunroof or convertible top operational?",
      "placeholder": "",
      "questionFormat": "HorizontalSwitch",
      "items": [
        "NA",
        "No",
        "Yes"
      ],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "Yes",
      "comments": null
    },
    {
      "name": "Entertainment System Operational",
      "placeholder": "",
      "questionFormat": "HorizontalSwitch",
      "items": [
        "No",
        "Yes"
      ],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "Yes",
      "comments": null
    },
    {
      "name": "Upholstery or seat damage?",
      "placeholder": "",
      "questionFormat": "HorizontalSwitch",
      "items": [
        "No",
        "Yes"
      ],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "No",
      "comments": null
    },
    {
      "name": "How many keys?",
      "placeholder": "",
      "questionFormat": "HorizontalSwitch",
      "items": [
        "Zero",
        "One",
        "Two"
      ],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "One",
      "comments": null
    },
    {
      "name": "Keyless start?",
      "placeholder": "",
      "questionFormat": "HorizontalSwitch",
      "items": [
        "No",
        "Yes"
      ],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "Yes",
      "comments": null
    },
    {
      "name": "Navigation system?",
      "placeholder": "",
      "questionFormat": "HorizontalSwitch",
      "items": [
        "No",
        "Yes"
      ],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "Yes",
      "comments": null
    },
    {
      "name": "All windows operational?",
      "placeholder": "",
      "questionFormat": "HorizontalSwitch",
      "items": [
        "No",
        "Yes"
      ],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "Yes",
      "comments": null
    },
    {
      "name": "Steering wheel",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_4A876A59-1C66-461A-9A57-3140F2C97AA7-1639-00000669A6BD778B.jpg",
      "comments": null
    },
    {
      "name": "Entertainment System",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_A685D137-4B2F-479D-9CB1-8B2A26DF3FC8-1639-00000669AD37BAE4.jpg",
      "comments": null
    },
    {
      "name": "OBD",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_796C8B35-85A2-4608-AE88-012338686B0B-1639-00000669B3B8CF1F.jpg",
      "comments": null
    },
    {
      "name": "Front seats",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_3D74B02C-6CE7-4470-B56A-6575C67FC701-1639-00000669BAD7B792.jpg",
      "comments": null
    },
    {
      "name": "Rear seats",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_6834DC73-753E-45B7-BE09-F19BAC7ED435-1639-00000669C12C3E8D.jpg",
      "comments": null
    },
    {
      "name": "Flaws 1",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_F5501900-D14E-44EC-BC7F-B12CE9CC5DB8-1639-00000669C8725104.jpg",
      "comments": null
    },
    {
      "name": "Flaws 2",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_7EAB5564-94FB-4F3F-AC30-789F4474C203-1639-00000669CFE7D2EC.jpg",
      "comments": null
    },
    {
      "name": "Flaws 3",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_89B52F14-5A67-4E39-9B64-2F63C302476F-1639-00000669D6C6D453.jpg",
      "comments": null
    },
    {
      "name": "Flaws 4",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_5D30C31A-DDD1-44A0-B86A-83753B615637-1639-00000669DCBD26A5.jpg",
      "comments": null
    },
    {
      "name": "Under hood",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_D1D5FDE5-1260-46B1-A5C5-969B27AAF0C1-1639-000006693F5A2DB3.jpg",
      "comments": null
    },
    {
      "name": "Front (Hood down)",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_5F5B41CB-A58C-457E-9157-54F53D89A655-1639-0000066946ACF62C.jpg",
      "comments": null
    },
    {
      "name": "Front",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_D2986244-BA48-48BC-9F2E-BF501DF6F33A-1639-000006694D1252CA.jpg",
      "comments": null
    },
    {
      "name": "Front right",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_B28EBBD9-8B93-49D7-80C0-515C78B863E3-1639-00000669537D8DE5.jpg",
      "comments": null
    },
    {
      "name": "Driver door",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_CE262375-E775-455E-85E8-2613FC87DCA3-1639-0000066958258C95.jpg",
      "comments": null
    },
    {
      "name": "Rear driver side door",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_A5966053-58C5-4EBA-B2C5-08E797701143-1639-000006695CE588D0.jpg",
      "comments": null
    },
    {
      "name": "Back right",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_9F4D5A52-055A-4CA3-B983-38C7658D8608-1639-0000066962CA00C0.jpg",
      "comments": null
    },
    {
      "name": "Trunk",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_A1FBFDDC-D0F5-46C6-886C-D90D883DA858-1639-000006696CD36AA2.jpg",
      "comments": null
    },
    {
      "name": "Rear",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_70DD9653-69A8-42E5-9AC0-08E1DBA0BE6D-1639-0000066971891E67.jpg",
      "comments": null
    },
    {
      "name": "Left rear",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_432DA3DD-6870-4056-8645-322203351CE3-1639-000006697680FFD4.jpg",
      "comments": null
    },
    {
      "name": "Rear passenger door",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_D7433B04-F28F-425D-BDE4-DA536E6813F5-1639-000006697B50CFA4.jpg",
      "comments": null
    },
    {
      "name": "Front passenger door",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_51467EC1-9D58-475D-99ED-68FF66BC5A92-1639-000006697FBA2064.jpg",
      "comments": null
    },
    {
      "name": "Front right",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_01F66781-0B72-4C75-9C88-E9A1534FFDCA-1639-00000669845B1419.jpg",
      "comments": null
    },
    {
      "name": "Roof",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_A21CA8B6-36E7-4171-B315-FC2DF52D438F-1639-0000066988879D71.jpg",
      "comments": null
    },
    {
      "name": "Under car",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_B7BE8A78-E90F-49C0-A1CF-0C0F96D5301C-1639-0000066996142B29.jpg",
      "comments": null
    },
    {
      "name": "Hood",
      "placeholder": "",
      "questionFormat": "NumberField",
      "items": [],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "12",
      "comments": null
    },
    {
      "name": "Front left fender",
      "placeholder": "",
      "questionFormat": "NumberField",
      "items": [],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "25",
      "comments": null
    },
    {
      "name": "Driver door",
      "placeholder": "",
      "questionFormat": "NumberField",
      "items": [],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "8",
      "comments": null
    },
    {
      "name": "Rear driver door",
      "placeholder": "",
      "questionFormat": "NumberField",
      "items": [],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "",
      "comments": null
    },
    {
      "name": "Back left fender",
      "placeholder": "",
      "questionFormat": "NumberField",
      "items": [],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "",
      "comments": null
    },
    {
      "name": "Rear/Trunk",
      "placeholder": "",
      "questionFormat": "NumberField",
      "items": [],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "",
      "comments": null
    },
    {
      "name": "Back right fender",
      "placeholder": "",
      "questionFormat": "NumberField",
      "items": [],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "",
      "comments": null
    },
    {
      "name": "Rear passenger door",
      "placeholder": "",
      "questionFormat": "NumberField",
      "items": [],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "",
      "comments": null
    },
    {
      "name": "Front passenger door",
      "placeholder": "",
      "questionFormat": "NumberField",
      "items": [],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "",
      "comments": null
    },
    {
      "name": "Roof",
      "placeholder": "",
      "questionFormat": "NumberField",
      "items": [],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "",
      "comments": null
    },
    {
      "name": "Front right fender",
      "placeholder": "",
      "questionFormat": "NumberField",
      "items": [],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "",
      "comments": null
    },
    {
      "name": "Front left tread",
      "placeholder": "",
      "questionFormat": "QualityColorCoded",
      "items": [],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "Worn out",
      "comments": null
    },
    {
      "name": "Back left tread",
      "placeholder": "",
      "questionFormat": "QualityColorCoded",
      "items": [],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "Like New",
      "comments": null
    },
    {
      "name": "Back right tread",
      "placeholder": "",
      "questionFormat": "QualityColorCoded",
      "items": [],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "Wearing",
      "comments": null
    },
    {
      "name": "Front right tread",
      "placeholder": "",
      "questionFormat": "QualityColorCoded",
      "items": [],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "Worn out",
      "comments": null
    },
    {
      "name": "Is there road rash under the front fender?",
      "placeholder": "",
      "questionFormat": "HorizontalSwitch",
      "items": [
        "No",
        "Yes"
      ],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "No",
      "comments": null
    },
    {
      "name": "Damage to front or rear lights?",
      "placeholder": "",
      "questionFormat": "HorizontalSwitch",
      "items": [
        "No",
        "Yes"
      ],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "No",
      "comments": null
    },
    {
      "name": "Have the bolts on the fender and/or hood been turned or chipped?",
      "placeholder": "",
      "questionFormat": "HorizontalSwitch",
      "items": [
        "No",
        "Yes"
      ],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "No",
      "comments": null
    },
    {
      "name": "Rust anywhere?",
      "placeholder": "",
      "questionFormat": "HorizontalSwitch",
      "items": [
        "No",
        "Yes"
      ],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "No",
      "comments": null
    },
    {
      "name": "All door handles/latches working?",
      "placeholder": "",
      "questionFormat": "HorizontalSwitch",
      "items": [
        "No",
        "Yes"
      ],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "No",
      "comments": null
    },
    {
      "name": "Frame/structural Damage?",
      "placeholder": "",
      "questionFormat": "HorizontalSwitch",
      "items": [
        "No",
        "Yes"
      ],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "No",
      "comments": null
    },
    {
      "name": "How many dents?",
      "placeholder": "",
      "questionFormat": "NumberField",
      "items": [],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "",
      "comments": null
    },
    {
      "name": "How many scratches?",
      "placeholder": "",
      "questionFormat": "NumberField",
      "items": [],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "",
      "comments": null
    },
    {
      "name": "Any chips or cracks in windshields?",
      "placeholder": "",
      "questionFormat": "HorizontalSwitch",
      "items": [
        "No",
        "Yes"
      ],
      "responseFormat": "Text",
      "defaultValue": "",
      "value": "No",
      "comments": null
    },
    {
      "name": "Driver License",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_777C4999-FE11-4E1E-B1B5-6746DA6C93DB-1639-00000668EED1C83A.jpg",
      "comments": null
    },
    {
      "name": "Title",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_0AB38AB8-DC9A-4DD2-B843-60AD2A52268A-1639-00000668FAB7BC15.jpg",
      "comments": null
    },
    {
      "name": "Registration",
      "placeholder": "",
      "questionFormat": "ImageCapture",
      "items": [],
      "responseFormat": "Image",
      "defaultValue": "",
      "value": "/private/var/mobile/Containers/Data/Application/454411F6-976B-43B9-A226-89D3FB8F4C5D/tmp/image_picker_0F776E36-0424-4651-92E0-C465950AF278-1639-0000066901B96321.jpg",
      "comments": null
    }
  ]
}''';