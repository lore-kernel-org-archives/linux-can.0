From: gianluca <gianlucarenzi@eurekelettronica.it>
Subject: CanBus2Ethernet Bridge
Date: Mon, 8 May 2017 11:31:52 +0200
Message-ID: <e17fc677-1f3a-5a29-10f8-d27cea173b47@eurekelettronica.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from qmail34.e-mind.com ([188.94.192.34]:52460 "HELO
        qmail.e-mind.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1751255AbdEHJii (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 8 May 2017 05:38:38 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello list!

I am looking for a simple bridge who collect canbus packets over a 
socketcan device (i.e. can0) and send them to a socket device (i.e. a 
network socket).

I have a embedded board who run Linux Debian with CanBus (i.MX6 with 
FlexCan) and I would like to send/receive those messages to a "server" 
who is listening on the network socket and "translate" them to can 
frames to an existing can device (i.e. vcan0 or a real can0 device).

Because on the "server" there is an application software who is using 
the socketcan device to exchange data and such.

I was thinking about socketcand daemon but to my knowledge has a few 
limitiations:

1- It uses the REAL socketcan device as accessing device (-i option 
[vcan0,can1] ...)
2- It uses the interface to bind to, and NOT the address to send the 
packets to (-l).

I would like to have something like this on the embedded (it does not 
work actually!!):

(iMX6 IP: 192.168.1.101)
# socketcand -i can0 -l 192.168.1.100

and on the server (192.168.1.100):

# socketcand -i vcan0 -l 192.168.1.101

In this way every packet sent from the application to the vcan0 can be 
routed through the ethernet to the iMX6 @ address 192.168.1.101 and 
every packet received from the real canbus CAN0 on the iMX6 can be 
routed to the server 192.168.1.100 to the vcan0 interface.

There is such possibility without writing a bridge from scratch???

Regards,
Gianluca Renzi
-- 
Eurek s.r.l.                          |
Electronic Engineering                | http://www.eurek.it
via Celletta 8/B, 40026 Imola, Italy  | Phone: +39-(0)542-609120
p.iva 00690621206 - c.f. 04020030377  | Fax:   +39-(0)542-609212
