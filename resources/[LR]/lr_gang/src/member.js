import React from 'react';
import {Container, Navbar, Nav, Row, Col, Button, Table} from 'react-bootstrap';
import './member.css'
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

class Member extends React.Component{
    constructor(props){
        super(props);
        this.label= "THÀNH VIÊN"
        this.tl = new TimelineLite({paused: true})
        this.backgroundRef = null
        this.state = {
            showPromoteModal: false,
            currentSelectedMember: null
        }
    }

    componentDidMount(){
        this.tl.set(".background", {x:-100, autoAlpha: 0}).from(".gang-name", 0.4, {x: 100, autoAlpha:0}).staggerFromTo(".table-row", 0.2, {x: 100, autoAlpha:0}, {x: 0, autoAlpha:1}, 0.1).to(".background", 1.5, {autoAlpha: 1, x:0}, "+=0.3");
        this.tl.play()
    }

    ////////////////FUNCTION////////////////
    FireMember(identifier){
        console.log(identifier)
        lr("POST", "https://lr_gang/FireMember", {identifier: identifier})
    }
    getGradeLabel(grade){
        for (var i in this.props.gangGrade){
            if (this.props.gangGrade[i].grade == grade){
                return(this.props.gangGrade[i].label)
            }
        }
    }
    Promote(){
        console.log(this.state.currentSelectedMember)
        lr("POST", "https://lr_gang/Promote", this.state.currentSelectedMember)
    }
    ///////////////ENDFUNC//////////////////

    render(){
        return(
            <div className="app-body"  ref={this.props.UpdatePageRef}>
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
                            <Row>
                                <div className="member-table">
                                    
                                    {this.props.members.map((player, index)=>(
                                        <Row className="table-row">
                                            <Col xs={2} className="table-col text status text-center">{player.isOnline ? <i className="fas fa-circle text-success"></i>:<i className="fas fa-circle text-danger"></i>}</Col>
                                            <Col className="table-col text name text-center">{player.name}</Col>
                                            <Col className="table-col text rank text-center">{this.getGradeLabel(player.grade)}</Col>
                                            <Col xs={5} className="table-col action text-center">
                                                <Row>
                                                    <Col>
                                                        <div 
                                                            className="btn-2 promote"
                                                            onClick={()=>this.setState({showPromoteModal: true, currentSelectedMember: player})}
                                                        >Thăng Chức</div>
                                                    </Col>
                                                    <Col>
                                                        <div 
                                                            className="btn-2 fire"
                                                            onClick={()=>this.FireMember(player.identifier)}
                                                        >
                                                            Xa Thải
                                                        </div>
                                                    </Col>
                                                </Row>
                                            </Col>
                                        </Row>
                                    ))}
                                </div>
                            </Row>
                            
                        </div>
                    </Col>
                </Row>
                <div className="copyright">copyright © LORAX</div>
                {this.state.showPromoteModal && (
                    <div className="modal-lr">
                        <div className="modal-content-lr">
                            <div className="modal-header-lr">
                                <span className="close"></span>
                                <h2>QUẢN LÝ THÀNH VIÊN</h2>
                            </div>
                            <div className="modal-body-lr">
                                <select className="modal-select-lr" value={this.state.currentSelectedMember.grade} onChange={(e)=>{
                                    var currentSelectedMember = this.state.currentSelectedMember;
                                    currentSelectedMember.grade = e.target.value
                                    this.setState({currentSelectedMember: currentSelectedMember})
                                }}>
                                    {this.props.gangGrade.map((v, index)=>{
                                        return(    
                                            <option className="modal-option-lr" value={v.grade}>
                                                {v.label}
                                            </option>
                                        )
                                    })}
  
                                </select>
                            </div>
                            <div className="modal-footer-lr">
                            <div 
                                className="lr-btn bottom-left modal-btn-left"
                                onClick = {()=>{this.setState({showPromoteModal: false}); this.Promote()}}
                            >
                                Xác Nhận
                            </div>
                            <div 
                                className="lr-btn bottom-right"
                                onClick = {()=>{ this.setState({showPromoteModal: false})}}
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

export default Member;