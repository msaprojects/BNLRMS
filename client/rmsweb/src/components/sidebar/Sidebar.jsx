import React from 'react'
import './sidebar.css'
import {HomeOutlined,CategoryOutlined, HourglassEmptyOutlined, PersonOutlineOutlined, ReceiptOutlined} from '@material-ui/icons'
export default function Sidebar() {
    return (
        <div className='sidebar'>
            <div className='sidebarWrapper'>
                <div className='sidebarMenu'>
                    <ul className='sidebarList'>
                        <h3 className='sidebarTitle'>MENU</h3>
                        <li className='sidebarListItem'>
                            <HomeOutlined className='sidebarIcon'/>
                            Dashboard
                        </li>
                        <li className='sidebarListItem'>
                            <CategoryOutlined  className='sidebarIcon'/>
                            Permintaan
                        </li>
                        <li className='sidebarListItem'>
                            <HourglassEmptyOutlined  className='sidebarIcon'/>
                            Progress
                        </li>
                        <li className='sidebarListItem'>
                            <PersonOutlineOutlined  className='sidebarIcon'/>
                            Pengguna
                        </li>
                        <h3 className='sidebarTitle'>LAPORAN</h3>
                        <li className='sidebarListItem'>
                            <ReceiptOutlined className='sidebarIcon'/>
                            Laporan Permintaan
                        </li>
                        <li className='sidebarListItem'>
                            <ReceiptOutlined  className='sidebarIcon'/>
                            Laporan Progress
                        </li>
                    </ul>
                </div>        
            </div>
        </div>
    )
}
