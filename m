From: "Romain Forlot [IoT.bzh]" <claneys@iot.bzh>
Subject: Using CAN_FD_FRAME with BCM socket
Date: Wed, 26 Apr 2017 11:19:15 +0200
Message-ID: <6e32a9c4-2a08-87ac-aa1e-88907db27304@iot.bzh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35890 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2995341AbdDZJTW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Apr 2017 05:19:22 -0400
Received: by mail-wm0-f50.google.com with SMTP id u65so44243775wmu.1
        for <linux-can@vger.kernel.org>; Wed, 26 Apr 2017 02:19:20 -0700 (PDT)
Received: from shamash.uruk.home (ARennes-659-1-166-117.w2-12.abo.wanadoo.fr. [2.12.149.117])
        by smtp.gmail.com with ESMTPSA id s137sm5186983wme.31.2017.04.26.02.19.17
        for <linux-can@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Apr 2017 02:19:18 -0700 (PDT)
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,

I must miss something because I don't get it BCM socket uses 
canfd_frame. If I use classic can_frame, it works without problems and I 
don't get it.

Is there someone use canfd_frame with broadcast manager ? Every example 
or source code I browse just use can_frame, only documentation talks 
about that.

Here is the code :

  38         struct {
  39           struct bcm_msg_head msg_head;
  40           struct canfd_frame frame[4]; /* just an example */
  41         } msg;
  42
  43         memset(msg.frame, 0, sizeof(msg.frame));
  44
  45         msg.msg_head.opcode  = RX_SETUP;
  46         msg.msg_head.can_id  = 0x620;
  47         msg.msg_head.flags   = SETTIMER|STARTTIMER|CAN_FD_FRAME;
  48         msg.msg_head.nframes = 1;
  49         msg.msg_head.count = 0;
  50         msg.msg_head.ival1.tv_sec = 0;
  51         msg.msg_head.ival1.tv_usec = 500000;
  52 //      msg.msg_head.ival2.tv_sec = 0;
  53 //      msg.msg_head.ival2.tv_usec = 100000;
  54         msg.frame[0].data[0]   = 0x00;
  55         msg.frame[0].data[1]   = 0x00;
  56         msg.frame[0].data[2]   = 0x00;
  57         msg.frame[0].data[3]   = 0x00;
  58         msg.frame[0].data[4]   = 0x00;
  59         msg.frame[0].data[5]   = 0x3C;
  60         msg.frame[0].data[6]   = 0x00;
  61         msg.frame[0].data[7]   = 0x00;
  62
  63         if(write(s, &msg, sizeof(msg)) < 0)
  64                 printf("This is the end!\n%s\n", strerror(errno));

Then I use select on socket to read frames. In fact, if I remove 
CAN_FD_FRAME it work even if my concatenated struct after bcm_msg_head 
is canfd_frame structure but it will only read size of can_frame which 
is normal.

Thanks by advance.

BR

-- 
Romain Forlot - Embedded Engineer - IoT.bzh
claneys@iot.bzh - www.iot.bzh - +33257620298

