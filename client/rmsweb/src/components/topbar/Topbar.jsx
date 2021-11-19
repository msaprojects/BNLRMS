import React from 'react'
import './topbar.css'
import {NotificationsNone, Settings} from '@material-ui/icons'
export default function Topbar() {
    return (
        <div className='topbar'>
            <div className='topbarWrapper'>
                <div className='topLeft'>
                    <span className='logo'>BNL RMS</span>
                </div>
                <div className='topRight'>
                    <div className='topbarIconContainer'>
                        <NotificationsNone/>
                        <span className='topIconBadge'>4</span>
                    </div>
                    <div className='topbarIconContainer'>
                        <Settings/>
                    </div>
                    <img src="https://avatars.githubusercontent.com/u/41048415?v=4" alt="" className='topAvatar'/>
                </div>
            </div>
        </div>
    )
}
