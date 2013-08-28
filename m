From: xuewentian <xuewt@embedinfo.com>
Subject: cansend app will block while it is sending RTR frames
Date: Wed, 28 Aug 2013 09:34:32 +0000 (UTC)
Message-ID: <loom.20130828T111851-325@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46649 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754814Ab3H1Jex (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 28 Aug 2013 05:34:53 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1VEc9M-0006Nf-7E
	for linux-can@vger.kernel.org; Wed, 28 Aug 2013 11:34:52 +0200
Received: from 183.37.235.205 ([183.37.235.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 28 Aug 2013 11:34:52 +0200
Received: from xuewt by 183.37.235.205 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 28 Aug 2013 11:34:52 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,

  I want to test sending a lot of RTR frames, because select/poll is no 
effect on the flow control, I add the usleep in the cansend app.
  
  The code segment is :
  

	while (infinite || loopcount--) {
		
		ret = write(s, &frame, sizeof(frame));
		if (ret == -1) {
			perror("write");
			printf("Please specify a more long delay time!\n");
			break;
		}
		usleep(delay);//flow control
	}

  Here the "delay" is about 200us, and I used "cansend can0 -r -e -l 500 -
i 0x1234567  0x11 0x22 0x33 0x44 0x55 0x66 0x77 0x88" command to send 500 
RTR frames.but candump on
the another board could only received the 336 frames,and candump app 
hasn't print the received RTR frames,and only count the received frmaes.
  and I debugged the send process in the kernel, and I found that it sleep 
on the copy_from_user in the memcpy_fromiovec of the raw_sendmsg
  
  err = memcpy_fromiovec(skb_put(skb, size), msg->msg_iov, size);  // in 
the raw_sendmsg function of the net/can/raw.c file.
	if (err < 0)
		goto free_skb;

  What about happens with the write of the cansend app? and I used the 
same way to send the 5000000 data frames, it didn't blocked.

Thanks a lot.

