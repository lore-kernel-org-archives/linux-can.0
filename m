From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: can-utils: usage with kernels prior to 3.6
Date: Fri, 01 Feb 2013 13:15:02 +0100
Message-ID: <510BB1C6.40000@volkswagen.de>
References: <CAGm1_kvzT8e7_7JNt6NUyHUccpFb0c9v8XP3RStOWw6uKhObtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr1.volkswagen.de ([194.114.62.75]:51039 "EHLO
	mr1.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab3BAMPR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 1 Feb 2013 07:15:17 -0500
In-Reply-To: <CAGm1_kvzT8e7_7JNt6NUyHUccpFb0c9v8XP3RStOWw6uKhObtA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: linux-can@vger.kernel.org

Am 01.02.2013 08:30, schrieb Yegor Yefremov:
> I've looked at the source code of the latest can-utils and it seems
> like one cannot use them with the kernels prior to 3.6 because of
> missing CAN FD support. The "struct can_frame" was replaced with the
> new one, so that candump, cangen etc. are using only the CAN FD frame
> structure.
> 
> Am I missing something?

Hello Yegor,

of course the tools can be used with older kernels too.

The struct canfd_frame is capable to contain a CAN frames as well as a CAN FD
frame. Therefore e.g. candump internally uses struct canfd_famres to handle
both frame types in the same manner.

The idea and a visualisation can be found here:

http://can-newsletter.org/engineering/standardization/nr_stand_can-fd_linux3.6_120703/

Does this answer your question?

Regards,
Oliver
