From: Yousof Ebneddin Hamidi <youebned@gmail.com>
Subject: Signal Driven SocketCAN Questions
Date: Thu, 4 Jan 2018 10:48:34 +0100
Message-ID: <CAM=RW1JfAk93sfECLSC0Wq9B6XMJYwof8=s5xq92CMUjkGjoZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59155 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752595AbeADKhk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Jan 2018 05:37:40 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mkl@pengutronix.de>)
        id 1eX2u2-0006tP-7d
        for linux-can@vger.kernel.org; Thu, 04 Jan 2018 11:37:38 +0100
Received: from [IPv6:2001:470:7eea:1122:3401:e268:282e:bd79] (unknown [IPv6:2001:470:7eea:1122:3401:e268:282e:bd79])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 86C7C2BB3A2
        for <linux-can@vger.kernel.org>; Thu,  4 Jan 2018 10:37:37 +0000 (UTC)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de

Hi,

I am not sure where to ask my question. I wanted to send this message
to linux-can@vger.kernel.org but probably that mailing list is not for
questions. If the sending this email to you is wrong please redirect
me to the correct person or mailing list or forum or what ever. Thanks

I am trying to write a Signal Driven SocketCan with ROS in Ubuntu.
I have two problems:
1- I do not get a signal for each arrival message. Or maybe the
process of the signal takes too much time that I miss some signals

2- To solve the above problem I am reading the buffer until it is
empty at each SIGIO. Therefore I guarantee that I read all the CAN
messages and their timestamp. The new problem emerges now. The order
of the read messages are not the same as the arrival order anymore and
there will be some errors in the order every few read operation.
Interestingly they have the correct timestamp.

on the image with the link below, the right side is the output of my
node and the left side is the output of the candump. As you can see
there is a error labeled with "Time Error"
https://i.imgur.com/OOOPl9L.png

Best regards,
Yousof

