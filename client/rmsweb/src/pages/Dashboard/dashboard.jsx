import React from 'react'
import Topbar from '../../components/topbar/Topbar'
import Sidebar from '../../components/sidebar/Sidebar'
import './dashboard.css'

export default function Dashboard() {
    return (
        <div>
            <Topbar/>
            <div className="container">
                <Sidebar/>
                HOLA
            </div>
        </div>
    )
}
