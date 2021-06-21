import React from 'react';
import ReactDOM from 'react-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import {Container, Navbar, Nav, Row, Col, Button} from 'react-bootstrap';
import './style.css'
import Home from './home'
import Member from './member'
import Store from './store'
import Upgrade from './upgrade'
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

class Main extends React.Component{
    constructor(props){
        super(props);
        this.state = {
            page: 1,
            show: false,
            gangName: "gangster",
            gangSrc: "https://image.freepik.com/free-vector/gangster-gorilla-with-necklace_43623-777.jpg",
            gangText: "Tác phẩm của Nguyễn Du chứa chan tinh thần nhân đạo – một chủ nghĩa nhân đạo thống thiết, luôn hướng tới đồng cảm, bênh vực, ngợi ca và đòi quyền sống cho con người, đặc biệt là người phụ nữ tài hoa mà bạc mệnh.",
            gangLevel: 2,
            gangMembers : 21,
            members : [
                {isOnline: true, name: "Lorax", grade: 0, identifier: "steam:100151251234"},
                {isOnline: true, name: "Lorax", grade: 2, identifier: "steam:100151251234"},
                {isOnline: true, name: "Lorax", grade: 1, identifier: "steam:100151251234"},
                {isOnline: true, name: "Lorax", grade: 3, identifier: "steam:100151251234"},
                {isOnline: true, name: "Lorax", grade: 2, identifier: "steam:100151251234"},
                {isOnline: true, name: "Lorax", grade: 2, identifier: "steam:100151251234"},
                {isOnline: true, name: "Lorax", grade: 2, identifier: "steam:100151251234"},
                {isOnline: true, name: "Lorax", grade: 2, identifier: "steam:100151251234"},
                {isOnline: true, name: "Lorax", grade: 2, identifier: "steam:100151251234"},
                {isOnline: true, name: "Lorax", grade: 2, identifier: "steam:100151251234"},
                {isOnline: true, name: "Lorax", grade: 2, identifier: "steam:100151251234"},
                {isOnline: true, name: "Lorax", grade: 2, identifier: "steam:100151251234"},
                {isOnline: true, name: "Lorax", grade: 2, identifier: "steam:100151251234"},
                {isOnline: true, name: "Lorax", grade: 2, identifier: "steam:100151251234"},
                {isOnline: true, name: "Lorax", grade: 2, identifier: "steam:100151251234"},
                {isOnline: true, name: "Lorax", grade: 2, identifier: "steam:100151251234"},
            ],
            store: [
                {itemType: "weapon", itemName:"WEAPON_KNIFE", itemLabel:"Knife", itemSrc: "http://51.79.163.4/inventory/items/WEAPON_KNIFE.png", price: 15000},
                {itemType: "weapon", itemName:"WEAPON_KNIFE", itemLabel:"Knife", itemSrc: "http://51.79.163.4/inventory/items/WEAPON_KNIFE.png", price: 15000},
                {itemType: "weapon", itemName:"WEAPON_KNIFE", itemLabel:"Knife", itemSrc: "http://51.79.163.4/inventory/items/WEAPON_KNIFE.png", price: 15000},
                {itemType: "weapon", itemName:"WEAPON_KNIFE", itemLabel:"Knife", itemSrc: "http://51.79.163.4/inventory/items/WEAPON_KNIFE.png", price: 15000},
                {itemType: "weapon", itemName:"WEAPON_KNIFE", itemLabel:"Knife", itemSrc: "http://51.79.163.4/inventory/items/WEAPON_KNIFE.png", price: 15000},
                {itemType: "weapon", itemName:"WEAPON_KNIFE", itemLabel:"Knife", itemSrc: "http://51.79.163.4/inventory/items/WEAPON_KNIFE.png", price: 15000},
                {itemType: "weapon", itemName:"WEAPON_KNIFE", itemLabel:"Knife", itemSrc: "http://51.79.163.4/inventory/items/WEAPON_KNIFE.png", price: 15000},
                {itemType: "weapon", itemName:"WEAPON_KNIFE", itemLabel:"Knife", itemSrc: "http://51.79.163.4/inventory/items/WEAPON_KNIFE.png", price: 15000},
                {itemType: "weapon", itemName:"WEAPON_KNIFE", itemLabel:"Knife", itemSrc: "http://51.79.163.4/inventory/items/WEAPON_KNIFE.png", price: 15000},
                {itemType: "weapon", itemName:"WEAPON_KNIFE", itemLabel:"Knife", itemSrc: "http://51.79.163.4/inventory/items/WEAPON_KNIFE.png", price: 15000},
                {itemType: "weapon", itemName:"WEAPON_KNIFE", itemLabel:"Knife", itemSrc: "http://51.79.163.4/inventory/items/WEAPON_KNIFE.png", price: 15000},
                {itemType: "weapon", itemName:"WEAPON_KNIFE", itemLabel:"Knife", itemSrc: "http://51.79.163.4/inventory/items/WEAPON_KNIFE.png", price: 15000},
                {itemType: "weapon", itemName:"WEAPON_KNIFE", itemLabel:"Knife", itemSrc: "http://51.79.163.4/inventory/items/WEAPON_KNIFE.png", price: 15000},
                {itemType: "weapon", itemName:"WEAPON_KNIFE", itemLabel:"Knife", itemSrc: "http://51.79.163.4/inventory/items/WEAPON_KNIFE.png", price: 15000},
                {itemType: "weapon", itemName:"WEAPON_KNIFE", itemLabel:"Knife", itemSrc: "http://51.79.163.4/inventory/items/WEAPON_KNIFE.png", price: 15000},
                {itemType: "weapon", itemName:"WEAPON_KNIFE", itemLabel:"Knife", itemSrc: "http://51.79.163.4/inventory/items/WEAPON_KNIFE.png", price: 15000},
                {itemType: "weapon", itemName:"WEAPON_KNIFE", itemLabel:"Knife", itemSrc: "http://51.79.163.4/inventory/items/WEAPON_KNIFE.png", price: 15000},
                {itemType: "weapon", itemName:"WEAPON_KNIFE", itemLabel:"Knife", itemSrc: "http://51.79.163.4/inventory/items/WEAPON_KNIFE.png", price: 15000},
            ],
            gangGrade : [
                {name: "recruit", label: "Đàn Em", grade: 0},
                {name: "employed", label: "Đàn Anh", grade: 1},
                {name: "co", label: "Đại Ca", grade: 2},
                {name: "boss", label: "Trùm", grade: 3}
            ],
            upgradeUnlock: [
                "WEAPON SMG (10.000$)",
                "KNIFE  (5.000$)",
                "ARMOUR (3.000$)"
            ],
            upgradeRequire: [
                "10.000.000$",
                "1.000 GEM",
                "Đủ 10 Thành viên",
                "Đủ 5000 điểm chiến công"
            ]
        }
        this.tl = new TimelineLite({paused: true})
        this.homeBtn = null
        this.memberBtn = null
        this.storeBtn = null
        this.upgradeBtn = null
        this.content = null
        this.pageContent = null
    }
    componentDidMount(){
        console.log(this.content)
        console.log(this.homeBtn)
        window.addEventListener("message", this.EventListener.bind(this));
        window.addEventListener("keyup", this.KeyListener.bind(this))
        /* this.tl.set(this.content, {autoAlpha : 1}).from(this.homeBtn, 1, { x: 100, autoAlpha: 0 }).from(this.memberBtn, 0.5, { x: 100, autoAlpha: 0 }, "-=0.25").from(this.storeBtn, 0.5, { x: 100, autoAlpha: 0 }, "-=0.25")
        .from(this.upgradeBtn, 0.5, { x: 100, autoAlpha: 0 })  */      
        this.tl.staggerFrom(".header-btn", 1, { x: 100, autoAlpha: 0 }, 0.2)
        this.tl.play()
    }
    componentDidUpdate(prop, state){
        this.tl.set(".background", {x:-100, autoAlpha: 0}).to(".background", 1.5, {autoAlpha: 1, x:0});
        this.tl.play()
    }
    EventListener(e){
        var event = e.data.event;
        var data = e.data.data;
        console.log(event, JSON.stringify(data));
        switch(event){
            case "toggle":
                if (data == true){
                    this.setState({show: true})
                }else{
                    this.setState({show: false})
                }
                break;
            case "init-data":
                this.setState(data)
                break;
        }
    }
    KeyListener(e){
        if(e.key == "Escape"){
            this.Close()
        }
    }
    PageAnim(page){
        console.log(page)
        if(page == this.state.page){
            return
        }
        this.tl.to(this.pageContent, 0.7, {x: -1000 , autoAlpha: 0}).call(this.SetPage.bind(this), [page])
    }
    UpdatePageRef(r){
        console.log("asd")
        console.log(r)
        this.pageContent = r
    }
    GetPage(props){
        console.log(this.state.page)
        switch(this.state.page){
            case -1:
                return(null)
                break;
            case 1:
                return(<Home {...props}/>)
                break;
            case 2:
                return(<Member {...props}/>)
                break;
            case 3:
                return(<Store {...props}/>)
                break;
            case 4:
                return(<Upgrade {...props}/>)
                break;
        }
    }
    SetPage(page){
        console.log("page", page)
        this.setState({
            page: page
        })
    }
    Close(){
        lr("POST", "https://lr_gang/Close", {})
    }

    /////////////////FUNCTION////////////////////
    handlerSetState(state){
        this.setState(state)
    }
    getGradeLabel(grade){
        this.state.gangGrade.map((v, index)=>{
            console.log(v.grade, grade)
            if(v.grade == grade){
                console.log(v.label)
                return(v.label)
            }
        })
    }
    ///////////////ENDFUNCTION///////////////////

    render(){
        var props = {
            page: this.state.page,
            Close: this.Close.bind(this),
            UpdatePageRef: this.UpdatePageRef.bind(this),
            gangName: this.state.gangName,
            gangSrc: this.state.gangSrc,
            gangText: this.state.gangText,
            gangLevel: this.state.gangLevel,
            gangMembers: this.state.gangMembers,
            members: this.state.members,
            store: this.state.store,
            upgradeUnlock: this.state.upgradeUnlock,
            upgradeRequire: this.state.upgradeRequire,
            handlerSetState: this.handlerSetState.bind(this),
            gangGrade: this.state.gangGrade,
            getGradeLabel: this.getGradeLabel.bind(this)
        }
        if(this.state.show){
            return(
                <Container>
                    <Row className="nav-bar" ref={row => {this.content = row}}>
                        <Col>
                            <div 
                                className={"header-btn text-center text-light home-btn " + (this.state.page == 1 ? "active" : "")}
                                data-page="1"
                                onClick={()=>this.PageAnim(1)}
                                ref={div => this.homeBtn = div}
                            >
                                Trang Chủ
                            </div>
                        </Col>
                        <Col>
                            <div 
                                className={"header-btn text-center text-light member-btn " + (this.state.page == 2 ? "active" : "")}
                                data-page="1"
                                onClick={()=>this.PageAnim(2)}
                                ref={div => this.memberBtn = div}
                            >
                                Thành Viên
                            </div>
                        </Col>
                        <Col>
                            <div 
                                className={"header-btn text-center text-light store-btn " + (this.state.page == 3 ? "active" : "")}
                                data-page="1"
                                onClick={()=>this.PageAnim(3)}
                                ref={div => this.storeBtn = div}
                            >
                                Cửa Hàng
                            </div>
                        </Col>
                        <Col>
                            <div 
                                className={"header-btn text-center text-light upgrade-btn " + (this.state.page == 4 ? "active" : "")}
                                data-page="1"
                                onClick={()=>this.PageAnim(4)}
                                ref={div => this.upgradeBtn = div}
                            >
                                Nâng Cấp
                            </div>
                        </Col>
                    </Row>
                    {this.GetPage(props)}
                </Container>
            )
        }else{
            return(null)
        }
    }
}

var rd = ReactDOM.render(<Main />, document.getElementById('app'))