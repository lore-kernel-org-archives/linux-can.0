From: Rein Appeldoorn <reinappeldoorn@gmail.com>
Subject: Re: SocketCAN support for a Serial-CAN controller
Date: Fri, 22 Apr 2016 13:17:19 +0200
Message-ID: <CAPO0vcvCBixyQn76ywVQ6GbNbHmB7sH7FqYB9t33qL72pdQDcw@mail.gmail.com>
References: <CAPO0vcvuOaGxcCA-722c60o4-k-6somqCD1nuaaV6tWiPkoiTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34922 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbcDVLRv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 22 Apr 2016 07:17:51 -0400
Received: by mail-lf0-f46.google.com with SMTP id c126so77408719lfb.2
        for <linux-can@vger.kernel.org>; Fri, 22 Apr 2016 04:17:50 -0700 (PDT)
In-Reply-To: <CAPO0vcvuOaGxcCA-722c60o4-k-6somqCD1nuaaV6tWiPkoiTw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,

Up until now, I've been working with SocketCAN via CANUSB adapters
from Lawycel (http://www.can232.com/?page_id=16). However, now we
received a new platform with another serial-can controller from
axiomtek (http://www.axiomtek.com/Default.aspx?MenuId=Products&FunctionId=ProductView&ItemId=8270).

I am able to communicate with the CAN controller via serial and
receive CAN frames. However, using slcand to create a socketcan
interface does not work. As I see here
https://github.com/linux-can/can-utils/blob/master/slcand.c , the
slcand program sends specific commands to the serial bus and then
creates a bridge between the socket and serial. However, the commands
are different for my CAN controller.

Can somebody give me some pointers how to get SocketCAN to work with
an arbitrary serial-can controller?

I'm am very new to these low level Linux things so I really would
appreciate your help / corrections. Thanks in advance,

-Rein
