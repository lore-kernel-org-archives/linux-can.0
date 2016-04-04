From: Kyle Crenshaw <kyle.crenshaw@me.com>
Subject: Can bus shield set up
Date: Mon, 04 Apr 2016 02:00:41 -0400
Message-ID: <EF5F25C2-BEAD-4379-83FC-DF0C656930C5@me.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from st11p06im-asmtp002.me.com ([17.172.125.150]:51971 "EHLO
	st11p06im-asmtp002.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbcDDHAp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 4 Apr 2016 03:00:45 -0400
Received: from [10.87.48.141]
 (mobile-166-137-098-104.mycingular.net [166.137.98.104])
 by st11p06im-asmtp002.me.com
 (Oracle Communications Messaging Server 7.0.5.36.0 64bit (built Sep  8 2015))
 with ESMTPSA id <0O53008NLI163O10@st11p06im-asmtp002.me.com> for
 linux-can@vger.kernel.org; Mon, 04 Apr 2016 06:00:43 +0000 (GMT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org


I have a canbus shield from elecfreaks.com and a pl2303 rs232 to usb cable hardware , and can-utils software installed.
I love would like to read the canbus data coming in through the shield by way of usb end of the cable.

Do I set this up with slcan as a can device (sudo ip link add dev slcan0 type can), ( slcand.....), or (slcan_attach...), or by another method I'm not aware of?

I'm running fedora 23 if it matters...

Thanks in advance.