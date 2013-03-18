From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: j1939 - first steps
Date: Mon, 18 Mar 2013 21:13:33 +0100
Message-ID: <5147756D.1060203@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:61647 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903Ab3CRUNg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Mar 2013 16:13:36 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Kurt,

following the idea from Marc (cloning linux-stable, check-out 3.7.10, adding
j1939 branch, applying the j1939-3.7 branch) i managed to get my linux-box
working with your stack.

Following the documentation, i did this (as root):

./ip link set vcan0 j1939 on
./ip addr show vcan0
./ip addr add dev vcan0 j1939 0x22
./ip addr show vcan0
6: vcan0: <NOARP,UP,LOWER_UP> mtu 72 qdisc noqueue state UNKNOWN
    link/can
    can-j1939 0x22 scope link

And this (as user):

./jsr -v vcan0:0x22
./jsr: bind(vcan0:0000000000000022), -99: Cannot assign requested address

./jsr -v 0x22
./jsr: bind(#34:-), -19: No such device


./jsr -v 22
./jsr: bind(#22:-), -19: No such device


Any idea?

Regards,
Oliver
