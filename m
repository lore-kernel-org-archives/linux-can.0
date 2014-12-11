From: pascal <pfifre.ext@orange.com>
Subject: J1939 message length
Date: Thu, 11 Dec 2014 10:44:39 +0000 (UTC)
Message-ID: <loom.20141211T112702-791@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51285 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756681AbaLKKuG (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 11 Dec 2014 05:50:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Xz1Js-0001fy-0l
	for linux-can@vger.kernel.org; Thu, 11 Dec 2014 11:50:04 +0100
Received: from machine107.rd.orange.com ([193.49.124.107])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 11 Dec 2014 11:50:04 +0100
Received: from pfifre.ext by machine107.rd.orange.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 11 Dec 2014 11:50:04 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

I've installed the patch for using j1939 socket CAN under linux 
(beagleBone black).

It works fine for receiving j1939 message and sending short message (8 
bytes max).

But when I try to send long message (>8 bytes long), but the message has 
not been sent.

I use the sendTo method to send frame.

Do I have to do something special to send long message?

I'm working with a 3.8.13 kernel on beaglebone black.

Thanks a lot

Pascal

