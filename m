From: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Subject: iso-tp: timeout handling for unknown packet size
Date: Wed, 23 Oct 2013 15:32:34 +0200
Message-ID: <CAJA4uhcj+ySw1j64vz4Ao1t62YzYcZfoNLkjsmFg-Pqf+mjy4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:39698 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab3JWNcy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Oct 2013 09:32:54 -0400
Received: by mail-ob0-f179.google.com with SMTP id uy5so761164obc.10
        for <linux-can@vger.kernel.org>; Wed, 23 Oct 2013 06:32:54 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>, Yannick Bedhomme <yannick.bedhomme@mobile-devices.fr>

Hello,

We are working with the current implementation of ISO-TP from Oliver
Hartkopp available on github. The implementation works well for us
with a slight limitation that we would like to discuss here.

We use ISO-TP to talk to OBD ECUs. In this context, our userspace
opens an ISO-TP socket and sends an OBD-CAN request to the ECU and
waits for a response over ISO-TP. To be able to receive large frames
over ISO-TP or to account for transmitter having a large inter frame
delay, we have to use large timeout values so we don't close the
socket while the packet is still being received.

We would like to know if an ECU is responding or not without having to
wait several seconds for a hypotetical packet to be received, do you
have any idea how we could do that?

Thanks,

-- 
Josselin Costanzi
  Embedded Linux System Engineer
