# Weather.look˚
<br>


<a href="https://bricktopia-define-world.notion.site/0c416e693eaf4921b5291ced0abce4a8?pvs=4"><img src="https://github.com/s1mjane/ossTeam/assets/100616572/a8144d05-9215-47e5-9483-a0e206d22323" width="1000"></a>



</br>

###  ⛅️  Background
**바쁜 아침, 날씨를 확인하고도 무엇을 입어야 할지 고민된 적 있지 않으신가요?** <br>
외출 준비로 바쁜 현대인들은 날씨를 확인해도 정보가질 와닿지 않아 무엇을 입을지 고민하며 시간을 보냅니다. 웨더룩˚은 해설을 통해 날씨를 이해하기 쉽게 알려주고 적절한 옷차림을 추천해 옷을 결정하는 과정을 단축시켜 줍니다.

</br>

### 🌧️  Problem & Solution  ☔️

| As-is  |  To-be  |
|----------|--------|
| 수치화 되어있는 날씨 정보가 직관적으로 와닿지 않는다는 문제점    |   수치화 되어있는 날씨 정보들을 종합적으로 해석해 직관적으로 이해되도록 전달 |
|날씨에 맞는 옷을 고르기까지의 과정이 많다는 문제점    |날씨에 맞는 옷차림을 카테고리화하여 추천   |

</br>

###  ☁️ Main Service
|오늘의 날씨 해설 |   오늘의 아이템 추천  |
|----------|--------|
| 직접 와닿는 말로 오늘의 날씨를 해석해드려요!   |  날씨에 따라 알맞는 옷차림을 추천드려요! |
| <img src="https://file.notion.so/f/s/d29fc129-9cb7-4079-91f2-9ac150961756/Untitled.png?id=164cc30d-3976-4e3e-aa82-d37f1f7e32c3&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=4MHyUjkZ2jyjUxUSw7FZziZYMDL2_vs79CfxA8Mu2DU&downloadName=Untitled.png" width=300>   |<img src="https://file.notion.so/f/s/86b16f2f-4345-4da1-aaae-48d916331d47/Untitled.png?id=2a7ca452-d28d-49b9-981d-b687f410faf7&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=dksOp8V0zjWsi9FCTHHytZk4iViB93d3Wn3Bj6jkv8w&downloadName=Untitled.png" width=300>
  
 <br>

### ⛈️  Function & Technique
| Functions |Technique |
|-----|---|
|**이해가 쏙쏙되는 날씨 해설** <br> 하루의 전체 날씨 정보를 이해하기 쉽도록 직관적으로 와닿는 해설을 보여줘요! |⚡️ chatGPT Summary |
|**빠르게 눈으로 스캔하는 옷차림** <br> 오늘 날씨에 맞는 옷차림을 카테고리로 추천해 챙겨야 하는 아이템을 빠르게 인식할 수 있어요!|⚡️ firebase  <br>⚡️ firestore |
|**편하게 귀로 듣는 날씨** <br> 해석된 날씨 정보와 옷차림 추천까지 오디오 브리핑을 통해 음성으로 들으면서 오늘의 룩을 골라봐요!|⚡️ briefing <br> ⚡️ text_to_speeach <br> ⚡️ perfect_volume_control|
|**무물보!** <br> 일상, 특별한 날, 여행 등 챗봇을 통해 날씨와 관련된 부가정보를 검색할 수 있어요! | ⚡️ chatGPT <br> ⚡️ speech_to_text|
|**터치 한 번으로 비교** <br> 날씨를 알고 싶은 다른 지역을 추가하고 지역 간의 날씨를 쉽게 비교할 수 있어요! | ⚡️ geolocator <br> ⚡️ pageView |
|**간단하게 확인하는 날씨** <br> 매일 아침, 알림을 통해 요약된 날씨 정보를 빠르게 확인할 수 있어요!|⚡️ notification|

<br>



### 📱 웨더룩 사용하기

<a href="https://bricktopia-define-world.notion.site/0c416e693eaf4921b5291ced0abce4a8?pvs=4"><img src="https://github.com/s1mjane/ossTeam/assets/100616572/738cba18-1e35-4955-b17b-b663827abdc8" width="500"></a>  <img src="https://file.notion.so/f/s/2cfd1b33-0608-4e25-a8c5-a3f4c6fa3813/Untitled.png?id=13465bac-29e6-438c-8377-e34c149e7fae&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=I0Ngbt2T7mP41Aq4G_jpPdEhTQg-zYT8jn4WxqpZdJU&downloadName=Untitled.png" width=00> <br>
 <img src="https://file.notion.so/f/s/3704e22c-7dd4-49ef-b676-aeb4249e85b1/Untitled.png?id=298191e5-90f7-475d-af6f-a4a397ddefef&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688824800000&signature=dW7yLbDmaVtpXrL7dPcOmcLEcjD8HvlCSyaFgTU_l-M&downloadName=Untitled.png" height=350>
 <img src="https://file.notion.so/f/s/51b25697-e21a-483a-a6de-d5657fe57873/Untitled.png?id=cbc33a96-7dcd-4aff-b20c-d22497958d96&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688824800000&signature=EHC-rd8F-YguOCshZ3JGm-Y5Q-wVPg7HM1Czx1u4RQU&downloadName=Untitled.png" height=350>
 

  <br>

  ⬇️ 클릭하고 Weather.look˚ 더 알아보기 ⬇️ <br> 
<a href="https://bricktopia-define-world.notion.site/0c416e693eaf4921b5291ced0abce4a8?pvs=4"><img src="https://file.notion.so/f/s/7b981eb9-2cbb-4ccd-bf55-944fcf8e5c2d/Untitled.png?id=72f53076-5e89-4adf-85bf-f07a4ef3f1e7&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688803200000&signature=cGlQkig8R5kXkSS4Vb_MxIDmjBKqFNKq6oTVLNCjdZ8&downloadName=Untitled.png" width="300"></a>

<br>
  
  ### 🧑🏻‍🎨 Color Reference

| Color             | Hex                                                                | Weather         | Hex |
| ----------------- | ------------------------------------------------------------------ | ------------|----- | 
| Primary |<img src="https://file.notion.so/f/s/87bc8dde-91de-4728-afa6-d6dd3f7205ec/Untitled.png?id=372c8e8d-5499-408c-9060-bb983a6463db&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688810400000&signature=e4D_ZI3eiFyO-nesa5jPl1ODwfTVOAG5egBXtF-g_L0&downloadName=Untitled.png" width=10> #5772D3| Orange |<img src="https://file.notion.so/f/s/6188ba3d-c52e-4cd1-959e-21458383cf2e/Untitled.png?id=c063bf3e-4bba-450e-b19c-66496e948026&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688810400000&signature=GM3vZoIyEEe-3XI7mzGiO-iSKF7BMtsV55RaD2OgI0A&downloadName=Untitled.png" width=10> #FFDDA9|
| Alert | <img src="https://file.notion.so/f/s/2a6d9dd8-e51b-46aa-b9f2-f55661640c93/Untitled.png?id=a554eba5-9ff3-4c87-9717-6b8efa8e6f99&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688810400000&signature=novLfA4EAjI72QbUbkj9xbwS4SVI1CXM-iDqIxOicGQ&downloadName=Untitled.png" width=10> #DD5441| Yellow | <img src="https://file.notion.so/f/s/b74135c4-90a7-4d27-86b0-262a73a1fcdc/Untitled.png?id=093c68a9-a070-4fdd-a7b7-f5ec3d415fde&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688810400000&signature=GfKVXxI1NNlBNJwJIs6zv7HS1F-z_HyRwndBsQQQJ_I&downloadName=Untitled.png" width=10> #FDFBB3|
| White | <img src="https://file.notion.so/f/s/f0946fa6-ee65-4505-8d44-b44a5f8a046d/Untitled.png?id=dce79d4a-9ab3-40d3-a20f-0c704631f218&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688810400000&signature=YwvCxikD6pDmS7FlM4FfHbF6SWjZWDrq2Ym0HJDSpvg&downloadName=Untitled.png" width=10> #FFFFFF | Mint |<img src="https://file.notion.so/f/s/e3de125c-c7d0-402e-b358-48ddb1999854/Untitled.png?id=d5d8cbd7-d0c2-4a25-b631-eb4c91929676&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688810400000&signature=6EWxRMTLG5XzBkkhhc4DboMBHNRy3jHj6MO5zGdV1Mc&downloadName=Untitled.png" width=10> #E1FEF6|
| Black | <img src="https://file.notion.so/f/s/54d30932-3597-4b7d-ab0b-198ad74bd6b6/Untitled.png?id=8f4ff46d-2a88-4cbd-9740-b7871e1810a7&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688810400000&signature=QVvyU9u7pGkLU1ODea8gbOXbeoV7i8gCBAQwHCv8mvI&downloadName=Untitled.png" width=10> #000000 | Blue | <img src="https://file.notion.so/f/s/0a6fbbbe-59cb-4123-b3d0-0d3da191af09/Untitled.png?id=dadf8854-a2cf-4feb-b372-4d83cdf35db6&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688810400000&signature=gY2YXMviyDltC-GzPwgj1Rby7D18PkK4UyCAuMaAUlA&downloadName=Untitled.png" width=10> #DBEDFD|
| Gray/Button_text | <img src="https://file.notion.so/f/s/c69b4292-2394-4c03-89b5-9e0a76d2751a/Untitled.png?id=ddad0fe3-c975-4b33-9d78-46ed37dd3fc2&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688810400000&signature=_t-CSMZUPdf0u9RvqTyrwI61GTcBtF9ip2-DvVvzH5Q&downloadName=Untitled.png" width=10> #9E9E9E | Dark blue |<img src="https://file.notion.so/f/s/6188ba3d-c52e-4cd1-959e-21458383cf2e/Untitled.png?id=c063bf3e-4bba-450e-b19c-66496e948026&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688810400000&signature=GM3vZoIyEEe-3XI7mzGiO-iSKF7BMtsV55RaD2OgI0A&downloadName=Untitled.png" width=10> #C1CFE3|
| Gray/Button_box| <img src="https://file.notion.so/f/s/88a25860-533e-41e0-b0b7-cddce6a529ad/Untitled.png?id=7b4f26b9-fffd-43c4-8961-2074eefecca1&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688810400000&signature=djgW8BdcgsXeJn4RZwxx3ekdKI0r_LfhQ-Z7LgycrsU&downloadName=Untitled.png" width=10> #E8E8E8 | Purple | <img src="https://file.notion.so/f/s/d5ccf2b4-d70a-4cd2-95d7-24b92245707a/Untitled.png?id=03fb5c0f-3fce-4540-96eb-41c2ddafb91a&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688810400000&signature=UmJRETkGHhtmvrEM37VNwE9IpYxSNTvUBNOR9hacmag&downloadName=Untitled.png" width=10 > #E3E0FF|
|Gray/Button_desactivated | <img src="https://file.notion.so/f/s/2a19260d-7732-4bbf-8d24-b594b0d3ad99/Untitled.png?id=f7c57f44-6c7f-4013-8a35-cf7235b4384e&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688810400000&signature=5syi6mcR6H2x_3DPljJ6P4uOd48PZJ-2OCkMmu9RD8s&downloadName=Untitled.png" width=10> #F4F4F4| Gray | <img src="https://file.notion.so/f/s/1d744c1d-2a56-46a1-9d03-ef3aeb55e7bb/Untitled.png?id=8c7687a5-b5c7-4b7f-bf50-490dad9b5c03&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688810400000&signature=ujnm_sMX1tGkm80NGMyQ1RNBl9PK05ygUfpW5voHWIk&downloadName=Untitled.png" width=10 > #E8E8E8|

<br>

### 🧑🏻‍💻 Stack
<div style={display:flex}>
    <img src="https://img.shields.io/badge/flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white">
<img src="https://img.shields.io/badge/firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=white">
  <img src="https://img.shields.io/badge/figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white">
  <img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">
  <img src="https://img.shields.io/badge/git-F05032?style=for-the-badge&logo=git&logoColor=white">
  <img src="https://img.shields.io/badge/notion-000000?style=for-the-badge&logo=notion&logoColor=white">
  <img src="https://img.shields.io/badge/slack-4A154B?style=for-the-badge&logo=slack&logoColor=white">

</div>

<br>

### 🧱 Team Brick-topia

| Evelyn | Yani | Leo | Mark | Jane |
| -- | -- | -- | -- | -- |
| Project Manager | Designer | Developer | Developer | Developer |
|<img src="https://github.com/s1mjane/ossTeam/assets/100616572/5f2e6c97-a0d0-473c-8e0a-3c0f2636ba31" >|<img src="https://github.com/s1mjane/ossTeam/assets/100616572/03df2a73-d360-4505-ba3e-39249fd0e3b5">|<img src="https://github.com/s1mjane/ossTeam/assets/100616572/b9661de4-bdcd-4814-b07b-bc2cf837950c" >|<img src="https://github.com/s1mjane/ossTeam/assets/100616572/6ee66f3b-21bb-4ddc-b021-528e85b0b96f" >|<img src="https://github.com/s1mjane/ossTeam/assets/100616572/cbcea093-c0ce-4327-bdb6-8f089a5513f3" >|
| <a href="https://disquiet.io/@pioneer_min"><img src="https://file.notion.so/f/s/96012e14-c4ce-4a9d-945d-b5bb269d709a/Untitled.png?id=b60b68ad-10d2-4728-81c6-056588989666&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=VBmAuzRElPUQXQyrR-lAqd0_HFUBCihhnNAvOji-D_w&downloadName=Untitled.png" width="100"></a>  |<a href="https://disquiet.io/@yysaeeun"><img src="https://file.notion.so/f/s/96012e14-c4ce-4a9d-945d-b5bb269d709a/Untitled.png?id=b60b68ad-10d2-4728-81c6-056588989666&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=VBmAuzRElPUQXQyrR-lAqd0_HFUBCihhnNAvOji-D_w&downloadName=Untitled.png" width="100"></a> | <a href="https://github.com/hyunwookoo13"><img src="https://file.notion.so/f/s/3938dfed-225b-4ef5-b4cc-154aeffba97a/Untitled.png?id=8006aadf-c093-46d6-bc32-29db190e01b1&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=P1sFg7KTwhM4TS2iLLWFI6G0ttUYrDXSCqQzSJ7iSCY&downloadName=Untitled.png" width="100"></a> <a href="https://disquiet.io/@21800030"><img src="https://file.notion.so/f/s/96012e14-c4ce-4a9d-945d-b5bb269d709a/Untitled.png?id=b60b68ad-10d2-4728-81c6-056588989666&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=VBmAuzRElPUQXQyrR-lAqd0_HFUBCihhnNAvOji-D_w&downloadName=Untitled.png" width="100"></a>  |  <a href="https://github.com/ssoup0224"><img src="https://file.notion.so/f/s/3938dfed-225b-4ef5-b4cc-154aeffba97a/Untitled.png?id=8006aadf-c093-46d6-bc32-29db190e01b1&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=P1sFg7KTwhM4TS2iLLWFI6G0ttUYrDXSCqQzSJ7iSCY&downloadName=Untitled.png" width="100"></a><a href="https://disquiet.io/@ssoup0224"><img src="https://file.notion.so/f/s/96012e14-c4ce-4a9d-945d-b5bb269d709a/Untitled.png?id=b60b68ad-10d2-4728-81c6-056588989666&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=VBmAuzRElPUQXQyrR-lAqd0_HFUBCihhnNAvOji-D_w&downloadName=Untitled.png" width="100"></a>  |  <a href="https://github.com/s1mjane"><img src="https://file.notion.so/f/s/3938dfed-225b-4ef5-b4cc-154aeffba97a/Untitled.png?id=8006aadf-c093-46d6-bc32-29db190e01b1&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=P1sFg7KTwhM4TS2iLLWFI6G0ttUYrDXSCqQzSJ7iSCY&downloadName=Untitled.png" width="100"></a>  <a href="https://disquiet.io/@s1mjane"><img src="https://file.notion.so/f/s/96012e14-c4ce-4a9d-945d-b5bb269d709a/Untitled.png?id=b60b68ad-10d2-4728-81c6-056588989666&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=VBmAuzRElPUQXQyrR-lAqd0_HFUBCihhnNAvOji-D_w&downloadName=Untitled.png" width="100"></a>|
<br>
