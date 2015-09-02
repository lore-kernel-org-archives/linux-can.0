From: Guillaume Picquet <guillaume@picquet.fr>
Subject: SocketCAN stops read after RX overflow, is it normal?
Date: Wed, 2 Sep 2015 12:17:44 +0200
Message-ID: <55E6CCC8.7010908@picquet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bounce-1.online.net ([62.210.16.43]:49989 "EHLO
	bounce-dc2-1.online.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750717AbbIBK4z (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Sep 2015 06:56:55 -0400
Received: from [62.210.16.40] (helo=smtpauth-dc2-1.online.net)
	by bounce-dc2-1.mutu.online.net with esmtpa (Exim 4.82)
	(envelope-from <guillaume@picquet.fr>)
	id 1ZX56x-00025S-RD
	for linux-can@vger.kernel.org; Wed, 02 Sep 2015 12:17:47 +0200
Received: from [78.224.49.244] (helo=[0.0.0.0])
	by smtpauth-dc2-1.online.net with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.82)
	(envelope-from <guillaume@picquet.fr>)
	id 1ZX56O-0006fH-RP
	for linux-can@vger.kernel.org; Wed, 02 Sep 2015 12:17:13 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi every one.

I=E2=80=99m not sure to post to the correct list, if so please correct =
me.

I=E2=80=99m doing tests on embedded hardware with integrated CAN bus in=
terface=20
(based on AT91). The driver provides Linux Socket API and I try to see=20
the limits:
I have one transmitter that writes CAN frames (CAN_RAW) as fast as=20
possible and a receiver that reads continuously.
After a moment the receiver gets an error frame signalling RX overflow.=
=20
I have no problem with that, it's normal and expected.
But question is why at this point no more frame is received ?

read() do not return, I've tested also with select() which return timeo=
ut.
(The restart-ms option is set)

I expected some dropped frames and others RX buffer errors but not the=20
end of reception.

The only way to recover the interface is to set it down and up again.

Thanks in advance.

Regards.
