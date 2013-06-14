From: "Janusz Uzycki" <janusz.uzycki@elproma.com.pl>
Subject: Re: RFC: (optional) software filtering in candump
Date: Fri, 14 Jun 2013 10:42:09 +0200
Message-ID: <DAD4CFC7EEFB419C81AB6F21681D2E2C@laptop2>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-2";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailmxout12.mailmx.agnat.pl ([193.239.45.92]:36844 "EHLO
	mailmxout12.mailmx.agnat.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750952Ab3FNIm2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 14 Jun 2013 04:42:28 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "\"Oliver Hartkopp\"" <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org


Hi.

I read the discussion. I agree the documentation should better explain 
multifilter filter policy. I think good workaround could be duplicated 
timestamp filtering - it seems simple to realize in userspace. The problem 
could be a lot of frames in short time. Then additional field in can_frame 
struct with packet_id in queue would be useful. The timestamp could be also 
added in the same way. How SIOCGSTAMP works now? What is difference in 
SO_TIMESTAMP? Where in kernel (socket layer or low level CAN driver, eq. 
irq) the timestamp is generated?

best regards
Janusz Uzycki

(text mode now)

