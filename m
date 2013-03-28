From: "Boris Baskevitch" <boris.baskevitch@annecy-elec.fr>
Subject: BCM periodic send
Date: Thu, 28 Mar 2013 17:11:36 +0100
Message-ID: <001e01ce2bce$ec5abcf0$c51036d0$@annecy-elec.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from riga.magic.fr ([188.130.33.24]:41684 "HELO riga.magic.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756392Ab3C1QSU (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 28 Mar 2013 12:18:20 -0400
Content-Language: fr
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello all,
This is my first message on this list, reading it already helped me a lot,
thank you to the contributors here.
I need some help on 2 issues, I'm using Socket-CAN BCM feature to send and
receive periodic messages:
I configured some periodic TX messages as shown below. It works great except
the fact that the actual period on the bus doesn't exactly match the
programmed period, it's a little slower, so I need to add a correction
factor to get the right period. I guess it's my system timer which is
incorrectly configured (I use a Fujitsu SoC with ARM Cortex A9). I don't set
the Jiffie parameter during the boot, so it's recalculated each time I
power-up the board. I don't know what is the time reference for Socket-CAN
(jiffies or something else?), do you know where should I look to correct it
?
Second point, I would like to change the content of the periodic frames at
runtime without reconfiguring the timer, ID and flags. What is the most
elegant way to do it ?
Thanks for your help !

Here's my periodic TX frame setup:

void CanBus::StartPeriodicSend(void)
{
     struct {
	struct bcm_msg_head msg_head;
	struct can_frame frame[1];
     } msg;
    
     
    msg.msg_head.opcode = TX_SETUP;
    msg.msg_head.flags = SETTIMER|STARTTIMER|TX_CP_CAN_ID|TX_COUNTEVT;
    msg.msg_head.count = 0;
    msg.msg_head.ival1.tv_sec = 0;
    msg.msg_head.ival1.tv_usec = 0;
    msg.msg_head.ival2.tv_sec = 0;
    msg.msg_head.ival2.tv_usec = 450000*0.979;		/* interval for the
following frames with correction factor */
    msg.msg_head.can_id = CAN_ID_ETAT_COMB;
    msg.msg_head.nframes = 1;
    msg.frame[0].can_id = CAN_ID_ETAT_COMB;
    msg.frame[0].can_dlc = 8;
    msg.frame[0].data[0] = 0;
    msg.frame[0].data[1] = 0;
    msg.frame[0].data[2] = 0;
    msg.frame[0].data[3] = 0;
    msg.frame[0].data[4] = 0;
    msg.frame[0].data[5] = 0;
    msg.frame[0].data[6] = 0;
    msg.frame[0].data[7] = 0;

    if (write(m_fd, &msg, sizeof(msg)) < 0){
	DiagnosticPlatform::ConsoleOut("CAN: ERROR: send BCM message !\n");
    }
}

