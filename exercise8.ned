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
        double maxDelay @unit(s) = default(200ms);
        @class(VoIPApp);
}

network Exercise8
{
    parameters:
        volatile int numWebDevicesWLAN = default(0);
        volatile int numWebDevicesLAN = default(0);

        @display("bgb=660,327");

    types:
    submodules:
        webDeviceWLAN[numWebDevicesWLAN]: WirelessHost {
            @display("p=104,59");
        }
        webDeviceLAN[numWebDevicesLAN]: StandardHost {
            @display("p=270,90");
        }
        accessPoint: AccessPoint {
            @display("p=136,188");
        }
        stationB: StandardHost {
            @display("p=498,244");
        }
        webServer: StandardHost {
            @display("p=498,143");
        }
        stationA: WirelessHost {
            @display("p=175,263");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            @display("p=299,21");
        }
        flatNetworkConfigurator: FlatNetworkConfigurator {
            @display("p=447,21");
        }
    connections:
        stationB.ethg++ <--> EtherLink {  datarate = 100Mbps; } <--> accessPoint.ethg++;
        webServer.ethg++ <--> EtherLink {  datarate = 100Mbps; } <--> accessPoint.ethg++;
        for i=0..numWebDevicesLAN-1 {
            webDeviceLAN[i].ethg++ <--> EtherLink {  datarate = 100Mbps; } <--> accessPoint.ethg++;
        }
}
