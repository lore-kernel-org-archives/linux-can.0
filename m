From: John Whitmore <arigead@gmail.com>
Subject: CAN Bus over TCP/IP
Date: Sat, 14 Jun 2014 02:55:23 +0100
Message-ID: <20140614015522.GC9911@griso.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:55241 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377AbaFNB4l (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Jun 2014 21:56:41 -0400
Received: by mail-we0-f170.google.com with SMTP id w61so3570979wes.15
        for <linux-can@vger.kernel.org>; Fri, 13 Jun 2014 18:56:40 -0700 (PDT)
Received: from griso.site (host86-131-25-58.range86-131.btcentralplus.com. [86.131.25.58])
        by mx.google.com with ESMTPSA id p18sm183420wik.3.2014.06.13.18.56.38
        for <linux-can@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 18:56:39 -0700 (PDT)
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Was contemplating something which would allow me to transmit CAN Bus frames
over TCP/IP. Searching throws up a few papers on the subject but wondered if
there's an OpenSource implementation already out there or any kind of spec on
the subject. Thought there might be an RFC on the subject but haven't thrown
up anything.
