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

class Store extends React.Component{
    constructor(props){
        super(props)
        this.label = "CỬA HÀNG"
        this.tl = new TimelineLite({paused: true})
        this.state = {
            showConfirmModal: false,
            currentSelect: null
        }
    }

    componentDidMount(){
        this.tl.set(".background", {x:-100, autoAlpha: 0}).from(".gang-name", 0.4, {x: 100, autoAlpha:0}).staggerFromTo(".store-item", 0.5, {x: 100, autoAlpha:0}, {x: 0, autoAlpha:1}, 0.1).to(".background", 1.5, {autoAlpha: 1, x:0}, "+=0.3");
        this.tl.play()
    }

    ///////////////FUNCTION/////////////
    Buy(){
        console.log(this.state.currentSelect.itemLabel, this.state.currentSelect.price)
        lr("POST", "https://lr_gang/Buy", this.state.currentSelect)
    }
    //////////////ENDFUNC//////////////

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
                            <div className="store-container">
                                
                                {this.props.store.map((item, index)=>(
                                    <div 
                                        className="store-item"
                                        style={{
                                            backgroundImage: `url(${item.itemSrc})`
                                        }}
                                    >
                                        <div className="price">${item.price}$</div>
                                        <div className="itemName">{item.itemLabel}</div>
                                        <div 
                                            className="buy-btn"
                                            onClick={()=>{
                                                this.setState({showConfirmModal: true, currentSelect: item})
                                            }}
                                        >
                                            <i className="fas fa-shopping-basket"></i>
                                        </div>
                                    </div>
                                ))}
                            </div>
                            
                        </div>
                    </Col>
                </Row>
                <div className="copyright">copyright © LORAX</div>
                {this.state.showConfirmModal && (
                    <div className="modal-lr">
                        <div className="modal-content-lr">
                            <div className="modal-header-lr">
                                <span className="close"></span>
                                <h2>CỬA HÀNG</h2>
                            </div>
                            <div className="modal-body-lr text-light text-center">
                                <h2>Mua <span style={{color: "#e84545"}}>{this.state.currentSelect.itemLabel}</span> với giá <span style={{color: "#fed049"}}>{this.state.currentSelect.price}$</span>?</h2>
                            </div>
                            <div className="modal-footer-lr">
                            <div 
                                className="lr-btn bottom-left modal-btn-left"
                                onClick = {()=>{this.setState({showConfirmModal: false}); this.Buy()}}
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

export default Store;