From: "Sandro Anders | CarMedialab" <sandro.anders@carmedialab.com>
Subject: Automatic baud rate detection
Date: Mon, 12 Mar 2012 18:55:56 +0100
Message-ID: <18F8639CFC8C7C4D819AB347808079D40144C16B@pluto.office.rac.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail2.racnet.net ([213.144.11.11]:51152 "EHLO mail2.racnet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952Ab2CLRzz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 Mar 2012 13:55:55 -0400
Received: from gate2.rac.de ([213.144.11.9] helo=pluto.office.rac.de)
	by mail2.racnet.net with esmtp (Exim (Debian))
	id 1S79TN-0000mw-00
	for <linux-can@vger.kernel.org>; Mon, 12 Mar 2012 18:55:53 +0100
Content-class: urn:content-classes:message
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

we currently developing our own socketcan driver and we have the
requirement to auto detect the baud rate at load time. Our HW is
supporting this but it seems this behavior is not configurable via IP
tools. Maybe I am  wrong but has anyone an suggestion to do this? We
thought to use baud rate 0 to detect this but this is obviously not
allowed. 

Thanks,
Sandro
