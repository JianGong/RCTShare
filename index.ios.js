/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
Image,
  Text,
  ScrollView,
TouchableOpacity,
  View,
TabBarIOS,
AlertIOS,

} = React;
var WX_TITLE = 'WX';
var WXApi = require('./wx/wx.js');

var Button  = React.createClass({
  render () {
    return (
  <TouchableOpacity onPress={this.props.onButtonPress}>
    <Text style={[this.props.style,{margin:10,justifyContent:'center',textAlign:'center'}]}>
      {this.props.title}
    </Text>
  </TouchableOpacity>
    );
  },
});


var WXView = React.createClass({
getInitialState:function(){
  return {
  sessionScene:'',
  scene:WXApi.WXReqTypeText,
  };
},
_showAlert: function(title:string, msg:string){
AlertIOS.alert(title,msg);
},
render: function (){
return (
<View style={{flex:1,flexDirection:'column',alignItems:'center',marginTop:20}}>
<View style={{flexDirection:'column',backgroundColor:'eoeed1'}}>
    <Image source={require('./img/micro_messenger.png')} style={{alignSelf:'center',maxWidth:300,maxHeight:300}}/>
    <Text  style={{alignSelf:'flex-start'}}>
      微信分享实例
    </Text>
</View>
  <View style={{alignSelf:'stretch',flexDirection:'column'}}>
      <Text style={{alignSelf:'flex-start',marginLeft:20}}>
          微信分享场景:{this.state.sessionScene}
      </Text>
      <View style={{flexDirection:'row',justifyContent:'space-around'}}>
          <Button title={'会话'}
           onButtonPress={(result)=> { this.setState({
             sessionScene:'会话'
           }); }}/>
          <Button title={'朋友圈'}
           onButtonPress={(result)=> { this.setState({
             sessionScene:'朋友圈'
           });  }}/>
          <Button title={'收藏'}
           onButtonPress={(result)=> { this.setState({
             sessionScene:'收藏'
           });  }}/>
      </View>
  </View>
        <ScrollView style={{backgroundColor:'white',flex:1,alignSelf:'stretch'}} >
          <Button title={'检测是否安装微信'} onButtonPress={()=>{WXApi.isWXAppInstalled((result)=>{console.log(result);this._showAlert('微信检测','是否安装'+result)}); }}/>
          <Button title={'获取Api版本号'}
          onButtonPress={(result)=>{WXApi.getApiVersion((result)=>{console.log(result);this._showAlert('微信Api版本','版本:'+result)})}} />
          <Button title={'分享文本数据'}
          onButtonPress={(result)=>{
              WXApi.sendReq({type:WXApi.WXReqTypeText,body:{bText:true,scene:WXApi.WXReqSceneSession,text:"O(∩_∩)O哈哈哈~，来自react native的分享"}}, (result)=>{
              this._showAlert('分享','反馈结果:'+result)
                });
            }} />
        <Button title={'分享图片信息'}
          onButtonPress = {(resut)=>{
            WXApi.sendReq({type:WXApi.WXReqTypeImage,body:{bText:false,scene:WXApi.WXReqSceneSession,text:"O(∩_∩)O哈哈哈~，来自react native的分享",message:{object:{imageUrl:'https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/logo_white_fe6da1ec.png'},thumbImage:'shop'}}}, (result)=>{
            this._showAlert('分享','反馈结果:'+result)
              });
          }
        }
/>


        </ScrollView>
      </View>
      );
},

});

var RCTShare = React.createClass({
getInitialState:function(){
return {
defaultItem:WX_TITLE,
itemSelected: false,
};
},

_itemSelected:function(title){
this.setState({
  defaultItem:title,
});
},
  render: function() {

    return (
      <TabBarIOS style = {styles.container} >
            <TabBarIOS.Item title ={WX_TITLE}
                onPress={()=>{this.setState({
                    defaultItem:WX_TITLE,
                });}}
               selected={this.state.defaultItem === WX_TITLE}>
            <WXView />
          </TabBarIOS.Item>

<TabBarIOS.Item title={'Unknown'}>

</TabBarIOS.Item>
      </TabBarIOS>
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('RCTShare', () => RCTShare);
