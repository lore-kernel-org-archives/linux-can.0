From: Ralph Potztal <ralph.potztal@espros.com>
Subject: Kvaser leaf light
Date: Thu, 19 Mar 2015 15:32:48 +0100 (CET)
Message-ID: <2201387.22.1426775565285.JavaMail.RPO@mac-rpo.local>
References: <22529898.19.1426775220044.JavaMail.RPO@mac-rpo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.espros.ch ([82.197.176.76]:50758 "EHLO mail.espros.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189AbbCSOkQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 19 Mar 2015 10:40:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.espros.com (Postfix) with ESMTP id 9D26A1A26B3
	for <linux-can@vger.kernel.org>; Thu, 19 Mar 2015 15:32:48 +0100 (CET)
Received: from mail.espros.com ([127.0.0.1])
	by localhost (mail.espros.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dReUcTvzPseW for <linux-can@vger.kernel.org>;
	Thu, 19 Mar 2015 15:32:48 +0100 (CET)
Received: from mail.espros.com (srv-zimbra.ch.epc [10.10.21.112])
	by mail.espros.com (Postfix) with ESMTP id 5C4E11A007D
	for <linux-can@vger.kernel.org>; Thu, 19 Mar 2015 15:32:48 +0100 (CET)
In-Reply-To: <22529898.19.1426775220044.JavaMail.RPO@mac-rpo.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org


Hi there, 

I'm trying hard to setup the Kvaser Leaf Light HS v2 with SocketCan on a Ubuntu 14.04.2 workstation. Unfortunately I failed so far and therefor wanted to ask you, if you can give me some help.

My goal is to use the leaf together with wireshark to spy a can bus in one of our automated test systems.

How I'm trying to set it up:
- loading kernel modules:
# modprobe can
# modprobe can_raw
# modprobe can_bcm
# modprobe kvaser_usb
# modprobe vcan

- plug the leaf

- check if the leaf is there:
# lsusb
Bus 001 Device 002: ID 0bfd:0120 Kvaser AB

-trying to set up the ip link:
# ip link set up can0
Cannot find device "can0"
# ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 00:22:68:3a:5f:03 brd ff:ff:ff:ff:ff:ff

This is where I fail, I cannot get a device can0 to set up. It works perfectly fine with the vcan virtual device, but not with the leaf.

Do you have any idea what I'm missing or doing wrong. Your help would be highly appreciated.

Btw: The leaf firmware is up to date. 

Many thanks and best regards,

Ralph


end


--- Disclaimer: --- 
This email and contents is for use only by the intended recipient. If you are not the individual or entity to whom it is addressed, you are hereby formally notified that any use, copying or distribution of this email and attachments, in whole or in part, is strictly prohibited. If you have received this email in error, please notify the sender and delete the message and attachment(s) from your system. Any views, opinions or information, expressed or contained in this email, are those of the sender and not necessarily reflect those of ESPROS Photonics AG. To help protect our environment, please avoid printing out this information unnecessarily.
