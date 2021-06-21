import React from 'react';
import {Container, Navbar, Nav, Row, Col, Button, Table} from 'react-bootstrap';
import './store.css'
import { gsap } from 'gsap'
import { TimelineLite, CSSPlugin } from "gsap/all";

function lr(type, url, data, cb){
    console.log(JSON.stringify(data))
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


class Upgrade extends React.Component{
    constructor(props){
        super(props)
        this.label = "CỬA HÀNG"
        this.backgroundRef = null
        this.tl = new TimelineLite({paused: true})
        this.state = {
            showConfirmModal: false
        }
    }

    componentDidMount(){
        this.tl.set(".background", {x:-100, autoAlpha: 0}).from(".gang-name", 0.4, {x: 100, autoAlpha:0}).staggerFromTo(".member-count", 0.5, {x: 100, autoAlpha:0}, {x: 0, autoAlpha:1}, 0.1).staggerFromTo(".gang-text", 0.5, {x: 100, autoAlpha:0}, {x: 0, autoAlpha:1}, 0.1, "+=0.1").to(".background", 1.5, {autoAlpha: 1, x:0}, "+=0.3");
        this.tl.play()
    }

    Upgrade(){
        lr("POST", "https://lr_gang/Upgrade", {})
    }

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
                            <h1 className="gang-name">{this.props.gangName}</h1>
                            <h1 className="member-count">Level {this.props.gangLevel}  <i className="fas fa-arrow-right"></i>  Level {this.props.gangLevel+1}</h1>
                            <h3 className="member-count">Mở Khóa</h3>
                            {this.props.upgradeUnlock.map((v, index)=>(
                                <h5 className="gang-text"><i className="far fa-dot-circle"></i> {v}</h5>
                            ))}
                            <h3 className="member-count">Yêu Cầu</h3>
                            {this.props.upgradeRequire.map((v, index)=>(
                                <h5 className="gang-text"><i className="far fa-dot-circle"></i> {v}</h5>
                            ))}
                        </div>
                    </Col>
                </Row>
                <div 
                    className="lr-btn bottom-right"
                    onClick={()=>{
                        this.setState({showConfirmModal: true})
                    }}
                >
                    Nâng Cấp
                </div>
                <div className="copyright">copyright © LORAX</div>
                {this.state.showConfirmModal && (
                    <div className="modal-lr">
                        <div className="modal-content-lr">
                            <div className="modal-header-lr">
                                <span className="close"></span>
                                <h2>NÂNG CẤP</h2>
                            </div>
                            <div className="modal-body-lr text-light text-center">
                                <h2>Nâng cấp lên <span style={{color: "#e84545"}}>Level {this.props.gangLevel+1}</span> ?</h2>
                            </div>
                            <div className="modal-footer-lr">
                            <div 
                                className="lr-btn bottom-left modal-btn-left"
                                onClick = {()=>{this.setState({showConfirmModal: false}); this.Upgrade()}}
                            >
                                Xác nhận
                            </div>
                            <div 
                                className="lr-btn bottom-right"
                                onClick = {()=>{ this.setState({showConfirmModal: false})}}
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

export default Upgrade;