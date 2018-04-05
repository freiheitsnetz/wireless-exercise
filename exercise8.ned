//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

import inet.node.inet.Router;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.EtherLink;
import inet.node.ethernet.EtherSwitch;
import inet.node.inet.StandardHost;
import inet.node.inet.WirelessHost;
import inet.node.wireless.AccessPoint;
import inet.applications.udpapp.UDPBasicApp;
import ned.DatarateChannel;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.networklayer.configurator.ipv4.FlatNetworkConfigurator;

simple VoIPApp extends UDPBasicApp
{
    parameters:
        double maxDelay @unit(s) = default(-1s);
        @class(VoIPApp);
}

network Exercise8
{
    parameters:
        volatile int numWebDevices = default(1);
        @display("bgb=550,252");

    types:
    submodules:
        webDevice[numWebDevices]: WirelessHost {
            @display("p=110,54");
        }
        accessPoint: AccessPoint {
            @display("p=71,135");
        }
        switchOrRouter: Router { // uncomment this line for router
            //switchOrRouter: EtherSwitch { // uncomment this line for switch
            @display("p=290,136");
        }
        stationB: StandardHost {
            @display("p=433,191");
        }
        webServer: StandardHost {
            @display("p=433,90");
        }
        stationA: WirelessHost {
            @display("p=110,210");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=211,26");
        }
        flatNetworkConfigurator: FlatNetworkConfigurator {
            @display("p=367,26");
        }
    connections:
        accessPoint.ethg++ <--> EtherLink {  datarate = 100Mbps; } <--> switchOrRouter.ethg++;
        stationB.ethg++ <--> EtherLink {  datarate = 100Mbps; } <--> switchOrRouter.ethg++; // uncomment this line for ethernet
        //stationB.pppg++ <--> EtherLink {  datarate = 100Mbps; } <--> switchOrRouter.pppg++; // uncomment this line for ppp
        webServer.ethg++ <--> EtherLink {  datarate = 100Mbps; } <--> switchOrRouter.ethg++;
}
