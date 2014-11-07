From: Paul Lever <svjeorgia@gmail.com>
Subject: candump error flags
Date: Fri, 7 Nov 2014 09:57:41 -0400
Message-ID: <CAHuoermNC-Cc79pK_qxkS4t+SjU=JkKtbxN9oZoBZRDUEnvYmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:38249 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbaKGN5m (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Nov 2014 08:57:42 -0500
Received: by mail-yh0-f42.google.com with SMTP id b6so2451673yha.29
        for <linux-can@vger.kernel.org>; Fri, 07 Nov 2014 05:57:41 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I'm trying to use the candump -e and -d options to catch errors. I
know that frames are being dropped, as I can see missing packets in
known sequences, yet I never see anything printed from candump
indicating any errors or dropped packets. Is there additional steps
needed to get output from -e/-d options? This is on a Beaglebone Black
platform.
My cmd line is:
candump -t a -e -d -r 16000 can0 > /media/testdata.raw&

Regards
Paul
