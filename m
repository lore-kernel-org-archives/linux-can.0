From: Stefan Tatschner <rumpelsepp@sevenbyte.org>
Subject: PCAN USB Pro FD one-shot
Date: Thu, 18 Feb 2016 13:56:19 +0100
Message-ID: <56C5BF73.9040402@sevenbyte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.sevenbyte.org ([5.9.90.188]:55464 "EHLO mail.sevenbyte.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946077AbcBRNRy (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 18 Feb 2016 08:17:54 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.sevenbyte.org (Postfix) with ESMTP id 9ED9F1260713
	for <linux-can@vger.kernel.org>; Thu, 18 Feb 2016 13:56:20 +0100 (CET)
Received: from mail.sevenbyte.org ([127.0.0.1])
	by localhost (mail.sevenbyte.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JH0xrMjOU2Wg for <linux-can@vger.kernel.org>;
	Thu, 18 Feb 2016 13:56:20 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>

Hey list,

I am currently working with the PCAN USB Pro FD device. I wanted to
experiment with the "one-shot" mode, which is proposed by "ip":

    $ ip link set can0 type can help
    Usage: ip link set DEVICE type can
    (...)
        [ loopback { on | off } ]
        [ listen-only { on | off } ]
        [ triple-sampling { on | off } ]
        [ one-shot { on | off } ]
        [ berr-reporting { on | off } ]
        [ fd { on | off } ]
        [ fd-non-iso { on | off } ]
        [ presume-ack { on | off } ]
    (...)

Unfortunately this seems currently not supported by the SocketCAN
driver. Do you have any more information on this topic?

Thanks in advance!

Stefan
