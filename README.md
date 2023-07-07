# Weather.look˚
![logo](https://file.notion.so/f/s/7b981eb9-2cbb-4ccd-bf55-944fcf8e5c2d/Untitled.png?id=72f53076-5e89-4adf-85bf-f07a4ef3f1e7&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688803200000&signature=cGlQkig8R5kXkSS4Vb_MxIDmjBKqFNKq6oTVLNCjdZ8&downloadName=Untitled.png)

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

### ☃️ 웨더룩 사용하기
 <img src="https://file.notion.so/f/s/2cfd1b33-0608-4e25-a8c5-a3f4c6fa3813/Untitled.png?id=13465bac-29e6-438c-8377-e34c149e7fae&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=I0Ngbt2T7mP41Aq4G_jpPdEhTQg-zYT8jn4WxqpZdJU&downloadName=Untitled.png" width=200> <br>
 <img src="https://file.notion.so/f/s/e7bbf75f-e45c-4fa6-9729-4f2961a05302/Untitled.png?id=e833cf1c-ba65-4132-8c84-6299ba804d26&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=EnoS5gFTwupYMd0FKSAteaSUcgqsChXuLs5hqS--KlY&downloadName=Untitled.png" width=200>
 <img src="https://file.notion.so/f/s/1b73b564-2fb1-40c6-8252-5da079381188/Untitled.png?id=a2ac4ab7-8cfd-4892-8079-f5b1775edba5&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=y_SyURDd3PU055ndO-OxAtYsntc4p1Yr9KwW2MmvDKU&downloadName=Untitled.png" width=200>
 <img src="https://file.notion.so/f/s/fbc528a1-ddc1-4987-bbf5-ef6de13c8a41/Untitled.png?id=afcb7467-2401-442e-a560-27cc5e4a59bf&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=dV436ifI4cYpNY5zra6sF40j_p8TdHL1_Rfoe1ELzoY&downloadName=Untitled.png" width=200>
 <img src="https://file.notion.so/f/s/645c0616-da83-44d0-9543-b8b0bb31435c/Untitled.png?id=665355cd-7fea-4222-9e8f-cb4567f2b2b9&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=doH55GCHxhlg_evByRggQ-gce12uV0U4NrwSpFo8iiw&downloadName=Untitled.png" width=200>
 <img src="https://file.notion.so/f/s/a6dea6a6-90f6-4670-825c-879b51b5f186/Untitled.png?id=7aaba6ee-3915-4078-8d72-593dfe2d704b&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=Z-YaPgU0aicLJjsFLvVikiowsIEV6ccL7rz5DfR8qiI&downloadName=Untitled.png" width=200>
 <img src="https://file.notion.so/f/s/1bcfc01b-cf74-4d02-9a68-39ddea2fc90d/Untitled.png?id=85058480-b526-4377-ab89-5bb135546d81&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=9gpb7C1ZVr07p0hmxx1wXdcVPcGNnsIMuY4gCrpfVjc&downloadName=Untitled.png" width=200>
 <img src="https://file.notion.so/f/s/351b6297-86f7-49d8-a88b-9b315409b01e/Untitled.png?id=60613e9e-064e-4c51-8e74-a51521058c8d&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=LI3mF8CxwuU6k4453-sEO8mK2zDHNc5b2SQWDefiE7I&downloadName=Untitled.png" width=200>
 <img src="https://file.notion.so/f/s/5d42071f-f5c4-4a40-b076-e753dcac8250/Untitled.png?id=ff141a3f-8cbe-4e02-a00d-23fc75401285&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=_QpDe2qmlFzIhbMt1ZY9zzedCrZZYphWHEfug2qHk0E&downloadName=Untitled.png" width=200>
 <img src="https://file.notion.so/f/s/354d5036-fb0a-43b9-86c9-9a91fb2c7ba7/Untitled.png?id=91251789-6195-417b-b08f-8edf86e4158b&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=Y4XiZQVZBClSEiWawAn5J7eIxGJapKtmQxvg2HdcJd8&downloadName=Untitled.png" width=200>
 <img src="https://file.notion.so/f/s/7a0f040c-eacf-42bb-8c1b-42deb2dd9ee3/Untitled.png?id=0fbc51ca-3551-42ef-adc9-012c17ac748f&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=353LPXWl7lJUZ1LvwZDYMx5KhWa4KM4sboL0PA4U7iE&downloadName=Untitled.png" width=200>
 <img src="https://file.notion.so/f/s/ca5b72d5-95d6-4fd6-9d92-c845e93c0233/Untitled.png?id=4adfe66c-6115-491d-804c-d1d74e18781d&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=KqBDrMGhyM1YpACQ-WrHcBCizccZCoYcz66N_ADaCrM&downloadName=Untitled.png" width=200>
 <img src="https://file.notion.so/f/s/13e91321-b625-4468-8c88-f718631ab380/Untitled.png?id=e0d86a6c-2f75-456d-81be-aafb159bd1f6&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=XcbIH9iNbuG2q9rahv8MZvJvmdpku4eeD_TbD19maPQ&downloadName=Untitled.png" width=200>
 


<br>

### 🕶️ Stack
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

### 🧱 Team Brick-topia
| Evelyn | Yani | Leo | Mark | Jane |
| -- | -- | -- | -- | -- |
| Project Manager | Designer | Developer | Developer | Developer |
|macsusp01@gmail.com | 21900474@handong.ac.kr | 21800030@handong.ac.kr |ssoup0224@gmail.com | s1mjane@handong.ac.kr|
| <a href="https://disquiet.io/@21800030"><img src="https://file.notion.so/f/s/96012e14-c4ce-4a9d-945d-b5bb269d709a/Untitled.png?id=b60b68ad-10d2-4728-81c6-056588989666&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=VBmAuzRElPUQXQyrR-lAqd0_HFUBCihhnNAvOji-D_w&downloadName=Untitled.png" width="100"></a>  |<a href="https://disquiet.io/@yysaeeun"><img src="https://file.notion.so/f/s/96012e14-c4ce-4a9d-945d-b5bb269d709a/Untitled.png?id=b60b68ad-10d2-4728-81c6-056588989666&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=VBmAuzRElPUQXQyrR-lAqd0_HFUBCihhnNAvOji-D_w&downloadName=Untitled.png" width="100"></a> |<a href="https://disquiet.io/@21800030"><img src="https://file.notion.so/f/s/96012e14-c4ce-4a9d-945d-b5bb269d709a/Untitled.png?id=b60b68ad-10d2-4728-81c6-056588989666&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=VBmAuzRElPUQXQyrR-lAqd0_HFUBCihhnNAvOji-D_w&downloadName=Untitled.png" width="100"></a> <br> <a href="https://github.com/"><img src="https://file.notion.so/f/s/3938dfed-225b-4ef5-b4cc-154aeffba97a/Untitled.png?id=8006aadf-c093-46d6-bc32-29db190e01b1&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=P1sFg7KTwhM4TS2iLLWFI6G0ttUYrDXSCqQzSJ7iSCY&downloadName=Untitled.png" width="100"></a> | <a href="https://disquiet.io/@ssoup0224"><img src="https://file.notion.so/f/s/96012e14-c4ce-4a9d-945d-b5bb269d709a/Untitled.png?id=b60b68ad-10d2-4728-81c6-056588989666&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=VBmAuzRElPUQXQyrR-lAqd0_HFUBCihhnNAvOji-D_w&downloadName=Untitled.png" width="100"></a> <br> <a href="https://github.com/ssoup0224"><img src="https://file.notion.so/f/s/3938dfed-225b-4ef5-b4cc-154aeffba97a/Untitled.png?id=8006aadf-c093-46d6-bc32-29db190e01b1&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=P1sFg7KTwhM4TS2iLLWFI6G0ttUYrDXSCqQzSJ7iSCY&downloadName=Untitled.png" width="100"></a> | <a href="[https://disquiet.io/@ssoup0224](https://github.com/s1mjane)"><img src="https://file.notion.so/f/s/96012e14-c4ce-4a9d-945d-b5bb269d709a/Untitled.png?id=b60b68ad-10d2-4728-81c6-056588989666&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=VBmAuzRElPUQXQyrR-lAqd0_HFUBCihhnNAvOji-D_w&downloadName=Untitled.png" width="100"></a> <br> <a href="https://github.com/s1mjane"><img src="https://file.notion.so/f/s/3938dfed-225b-4ef5-b4cc-154aeffba97a/Untitled.png?id=8006aadf-c093-46d6-bc32-29db190e01b1&table=block&spaceId=2adb39f3-ae8a-4d22-9e58-517958962188&expirationTimestamp=1688817600000&signature=P1sFg7KTwhM4TS2iLLWFI6G0ttUYrDXSCqQzSJ7iSCY&downloadName=Untitled.png" width="100"></a> |
