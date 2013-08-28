From: xuewentian <xuewt@embedinfo.com>
Subject: Re: cansend app will block while it is sending RTR frames
Date: Wed, 28 Aug 2013 14:21:46 +0000 (UTC)
Message-ID: <loom.20130828T155531-350@post.gmane.org>
References: <loom.20130828T111851-325@post.gmane.org> <521DED99.6010606@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47188 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752780Ab3H1OWG (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 28 Aug 2013 10:22:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1VEgdH-0005h6-LA
	for linux-can@vger.kernel.org; Wed, 28 Aug 2013 16:22:03 +0200
Received: from 113.97.237.221 ([113.97.237.221])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 28 Aug 2013 16:22:03 +0200
Received: from xuewt by 113.97.237.221 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 28 Aug 2013 16:22:03 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Marc Kleine-Budde <mkl <at> pengutronix.de> writes:

> 
> On 08/28/2013 11:34 AM, xuewentian wrote:
> > Hi all,
> > 
> >   I want to test sending a lot of RTR frames, because select/poll is no 
> > effect on the flow control, I add the usleep in the cansend app.
> >   
> >   The code segment is :
> >   
> > 
> > 	while (infinite || loopcount--) {
> > 		
> > 		ret = write(s, &frame, sizeof(frame));
> > 		if (ret == -1) {
> > 			perror("write");
> > 			printf("Please specify a more long delay time!\n");
> > 			break;
> > 		}
> > 		usleep(delay);//flow control
> > 	}
> > 
> >   Here the "delay" is about 200us, and I used "cansend can0 -r -e -l 500 
-
> > i 0x1234567  0x11 0x22 0x33 0x44 0x55 0x66 0x77 0x88" command to send 
500 
> > RTR frames.but candump on
> > the another board could only received the 336 frames,and candump app 
> > hasn't print the received RTR frames,and only count the received frmaes.
> >   and I debugged the send process in the kernel, and I found that it 
sleep 
> > on the copy_from_user in the memcpy_fromiovec of the raw_sendmsg
> >   
> >   err = memcpy_fromiovec(skb_put(skb, size), msg->msg_iov, size);  // in 
> > the raw_sendmsg function of the net/can/raw.c file.
> > 	if (err < 0)
> > 		goto free_skb;
> 
> How have you measured that the kernel sleeps in that function? How long
> does it sleep?

**************
my reply:

I found the cansend app will always sleep after sending 336 RTR frames by 
using "cansend can0 -r -e -l 500 -i 0x1234567  0x11 0x22 0x33 0x44 0x55 0x66 
0x77 0x88". I must press ctrl+c to cancel it,after cancelling
it,and I ran "cansend can0 -r -e -i 0x1234567  0x11 0x22 0x33 0x44 0x55 0x66 
0x77 0x88" for send another RTR frame, it could be sent successfully.
and I tested "cansend can0 -r -e -l 500 -i 0x1234567  0x11 0x22 0x33 0x44 
0x55 0x66 0x77 0x88 &" to run background, and it still sent 336 RTR frames, 
and the process was pending, and I could still send RTR
frames on the serial terminal.
And I used command "cansend can0 -e -l 5000000 -i 0x1234567  0x11 0x22 0x33 
0x44 0x55 0x66 0x77 0x88" to send 50000000 data frames,the cansend app could 
return to serial terminal. It didn't block.
The problem seemed to has no relationship with can driver because it still 
could send RTR frames after the problem occurred. I didn't know why it was 
always sleeping on the copy_from_user function.
any suggestion for me? 

Thanks a lot for your reply.








