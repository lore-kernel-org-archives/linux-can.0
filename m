From: xuewentian <xuewt@embedinfo.com>
Subject: candump app will lost rx packets while it prints the received data frames
Date: Wed, 28 Aug 2013 09:17:59 +0000 (UTC)
Message-ID: <loom.20130828T111233-886@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36985 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616Ab3H1JZF (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 28 Aug 2013 05:25:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1VEbzr-0006rf-2B
	for linux-can@vger.kernel.org; Wed, 28 Aug 2013 11:25:03 +0200
Received: from 183.37.235.205 ([183.37.235.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 28 Aug 2013 11:25:03 +0200
Received: from xuewt by 183.37.235.205 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 28 Aug 2013 11:25:03 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,

  I wonder that when the can select/poll bug can be fixed ? What reason 
has it not been fixed yet? Thanks a lot.

 and now I encounter another problem, I use a sufficient delay for cansend 
on the first borad, and anther board using candump to
receive the data frame.

board 1:
cansend can0  -l 500 -i 0x123 0x11 0x22 0x33 0x44 0x55 0x66 0x77 
0x88   //cansend I have added the delay,and no any write failaure report

board 2:
candump can0    // on the serial terminal, I have only received about 434
                // data frames which are printed on the serial
                // terminal,and no any read error information

and use "ifconfig can0" on the two boards, I found that board 1 has 
increased 500 "TX packets",and board 2 has also increased 500 "RX 
packets", but candump app seemed that lost some packets. what reason is 
it??

Thanks a lot.

