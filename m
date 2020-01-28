From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Tutorial to use the M_CAN IP cores with a STM32MP157A-DK1 dev kit
Date: Tue, 28 Jan 2020 18:50:10 +0100
Message-ID: <392f401a-f785-094d-2043-37197312c08c@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:15437 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1RuU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 Jan 2020 12:50:20 -0500
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 46.1.7 DYNA|AUTH)
        with ESMTPSA id R0798bw0SHoIEoa
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
        for <linux-can@vger.kernel.org>;
        Tue, 28 Jan 2020 18:50:18 +0100 (CET)
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>

To whom it may concern ...

I was searching for a development kit that allows SocketCAN testing with 
a Bosch M_CAN IP core.

The STM32MP157A-DK1 dev kit contains a M_CAN and a MTT_CAN (time 
triggered) IP core but has no CAN transceivers and no device tree 
configuration to access the CAN rx/tx lines of the two CAN interfaces.

The tutorial can be found here:

https://github.com/hartkopp/M_CAN-on-STM32MP157A-DK1

Have fun,
Oliver
