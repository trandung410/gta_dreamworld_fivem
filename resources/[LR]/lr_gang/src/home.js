import React from 'react';
import {Container, Navbar, Nav, Row, Col, Button, Image, Modal} from 'react-bootstrap';
import './home.css'
import { gsap } from 'gsap'
import { TimelineLite, CSSPlugin } from "gsap/all";
gsap.registerPlugin(CSSPlugin)

function lr(type, url, data, cb){
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (cb){
                cb(xhr.response);
            }
        }
    }
    
    xhr.open(type, url, true);
    xhr.send(JSON.stringify(data));
}

class Home extends React.Component{
    constructor(props){
        super(props);
        this.label = "TRANG CHỦ"
        this.header = null
        this.tl = new TimelineLite({paused: true})
        this.backgroundRef = null
        this.state = {
            showLogoModal: false,
            showSloganModal: false,
            showQuitModal: false,
            logoUrl: "",
            slogan: ""
        }
    }
    componentDidMount(){
        this.tl.set(".background", {x:-100, autoAlpha: 0}).from(this.header, 0.4, {x: 100, autoAlpha:0}).from(this.levelRef, 0.2, {x: 100, autoAlpha:0}, "+=0.2").from(this.memberRef, 0.2, {x: 100, autoAlpha:0}).from(this.textRef, 0.2, {x: 100, autoAlpha:0}).to(".background", 1.5, {autoAlpha: 1, x:0});
        this.tl.play()
    }
    
    /////////FUNCTION/////////
    changeState(key, val){
        this.setState({[key]: val})
    }
    onChangeText(key, val){
        this.setState({[key]:val})
    }
    changeLogo(){
        console.log(this.state.logoUrl)
        this.props.handlerSetState({gangSrc: this.state.logoUrl})
        lr("POST", "https://lr_gang/ChangeLogo", {data: this.state.logoUrl})

    }
    changeSlogan(){
        console.log(this.state.slogan)
        this.props.handlerSetState({gangText: this.state.slogan})
        lr("POST", "https://lr_gang/ChangeSlogan", {data: this.state.slogan})
    }
    QuitGang(){
        lr("POST", "https://lr_gang/QuitGang", {})
        this.props.Close()
    }
    ////////ENDFUNCTION///////
    render(){
        return(
            <div className="app-body" ref={this.props.UpdatePageRef}>
                <div 
                    className="background"
                    style={{
                        backgroundImage : `-webkit-linear-gradient(left, 
                            rgba(34,40,49,0.3) 0%, 
                            rgba(34,40,49,0.6) 25%,
                            rgba(34,40,49,0.8) 50%,
                            rgba(34,40,49,1) 75%,
                            rgba(34,40,49,1) 100%
                        ),
                        url(${this.props.gangSrc})`
                    }}
                ></div>
                <Row>
                    <Col className="text-light" xs={5}>
                        {/* <Image src="https://image.freepik.com/free-vector/gangster-girl-holding-gun-vector_43623-560.jpg" roundedCircle /> */}
                    </Col>
                    <Col className="gang-info text-light text-right">
                        <div className="header">
                            <h1 className="gang-name" ref={h1 => this.header = h1}>{this.props.gangName}</h1>
                            <h1 className="member-count" ref={h1 => this.levelRef = h1}>Level {this.props.gangLevel}</h1>
                            <h3 className="member-count" ref={h1 => this.memberRef = h1}>Thành Viên: {this.props.gangMembers}</h3>
                            <h4 className="gang-text" ref={h1 => this.textRef = h1}>{this.props.gangText}</h4>
                        </div>
                    </Col>
                </Row>
                <div 
                    className="lr-btn bottom-right"
                    onClick={()=>{
                        this.setState({showQuitModal: true})
                    }}
                >
                    Thoát Gang
                </div>
                <div 
                    className="lr-btn bottom-left edit-logo"
                    onClick={()=> this.setState({showLogoModal: true})}
                >
                    Sửa Logo
                </div>
                <div 
                    className="lr-btn bottom-left edit-slogan"
                    onClick={()=> this.changeState("showSloganModal", true)}
                >
                    Sửa Slogan
                </div>
                <div className="copyright">copyright © LORAX</div>
                {this.state.showLogoModal && (
                    <div className="modal-lr">
                        <div className="modal-content-lr">
                            <div className="modal-header-lr">
                                <span className="close"></span>
                                <h2>LOGO</h2>
                            </div>
                            <div className="modal-body-lr">
                                <input className="modal-input-lr" type="text" placeholder="Nhập đường dẫn mới của logo" onChange= {e=> this.onChangeText('logoUrl', e.target.value)}> 
                                
                                </input>
                            </div>
                            <div className="modal-footer-lr">
                            <div 
                                className="lr-btn bottom-left modal-btn-left"
                                onClick = {()=>{this.changeLogo(); this.changeState("showLogoModal", false)}}
                            >
                                Xác Nhận
                            </div>
                            <div 
                                className="lr-btn bottom-right"
                                onClick = {()=>{this.changeState("showLogoModal", false)}}
                            >
                                Hủy
                            </div>
                            </div>
                        </div>
                    </div>
                )}
                {this.state.showSloganModal && (
                    <div className="modal-lr">
                        <div className="modal-content-lr">
                            <div className="modal-header-lr">
                                <span className="close"></span>
                                <h2>SLOGAN</h2>
                            </div>
                            <div className="modal-body-lr">
                                <input className="modal-input-lr" type="text" placeholder="Nhập slogan mới" onChange= {e=> this.onChangeText('slogan', e.target.value)}> 
                                
                                </input>
                            </div>
                            <div className="modal-footer-lr">
                            <div 
                                className="lr-btn bottom-left modal-btn-left"
                                onClick = {()=>{this.changeSlogan();this.changeState("showSloganModal", false)}}
                            >
                                Xác Nhận
                            </div>
                            <div 
                                className="lr-btn bottom-right"
                                onClick = {()=>{ this.changeState("showSloganModal", false)}}
                            >
                                Hủy
                            </div>
                            </div>
                        </div>
                    </div>
                )}
                {this.state.showQuitModal && (
                    <div className="modal-lr">
                    <div className="modal-content-lr">
                        <div className="modal-header-lr">
                            <span className="close"></span>
                            <h2>SLOGAN</h2>
                        </div>
                        <div className="modal-body-lr text-light text-center">
                            <h3> Bạn xác nhận muốn thoát {this.state.gangName} ? </h3>
                        </div>
                        <div className="modal-footer-lr">
                        <div 
                            className="lr-btn bottom-left modal-btn-left"
                            onClick = {()=>{
                                this.setState({showQuitModal: false});
                                this.QuitGang()
                            }}
                        >
                            Xác Nhận
                        </div>
                        <div 
                            className="lr-btn bottom-right"
                            onClick = {()=>{
                                this.setState({showQuitModal: false})
                            }}
                        >
                            Hủy
                        </div>
                        </div>
                    </div>
                </div>
                )}
            </div>
        )
    }
}

export default Home;