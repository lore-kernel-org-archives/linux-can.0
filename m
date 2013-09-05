From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: can acknowledgment
Date: Thu, 05 Sep 2013 10:31:46 +0200
Message-ID: <818b112277dbc87b883edf93f165ecff@grandegger.com>
References: <CAJU5jUJBe49CsixJcy292Qp0VruPJo+1_FSp3FxyNFxjZDJhLQ@mail.gmail.com>
 <11071630B606A2488DE633430B530FDE57F07118@ELS-EX01-PV.KSTG.corp>
 <CAJU5jU+gp+Zihug9KW5-6VwkKjw3bhr=33v=Kd-_u-r4eGDXng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:50261 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934900Ab3IEIlD (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 5 Sep 2013 04:41:03 -0400
In-Reply-To: <CAJU5jU+gp+Zihug9KW5-6VwkKjw3bhr=33v=Kd-_u-r4eGDXng@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Muldoon <mbmuldoon07@gmail.com>
Cc: "Aiken, Scott" <Scott.Aiken@karlstorz.com>, linux-can@vger.kernel.org

On Wed, 4 Sep 2013 16:40:37 -0400, Michael Muldoon <mbmuldoon07@gmail.com>

wrote:

> Thanks for responding.  The bitrate is definitely right if I send the

> candump command I can see the traffic being sent by the other two

> devices on the network. The problem is if I take either of the other

> two devices off the network candump sees nothing and at not point does

> cansend ever work.



What does "ip -d -s link show can0" list after you try sending out

messages?

And what does "candump -e any,0:0,#FFFFFFFF" report while sending?



Wolfgang.


