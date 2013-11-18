From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: fix sja1000 pre_irq/post_irq handling
Date: Mon, 18 Nov 2013 14:13:55 +0100
Message-ID: <528A1293.8080807@hartkopp.net>
References: <5288CFEF.3060701@hartkopp.net> <52892C36.8060709@grandegger.com> <5289B0EF.3070507@hartkopp.net> <673f31d86a6b890f45ab63fb3799cbf0@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:28459 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057Ab3KRNN6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Nov 2013 08:13:58 -0500
In-Reply-To: <673f31d86a6b890f45ab63fb3799cbf0@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

On 18.11.2013 08:48, Wolfgang Grandegger wrote:

> 
> 
> Another thing I don't like is that the device present check is done for
> 
> all devices including devices which will never hotplug. I think this
> 
> code has been introduced for the PCMCIA/PCcard CAN controllers. I would
> 
> prefer somethink like:
> 
> 
> 
>          if (priv->hotpluggable && status == 0xFF &&
> 
>              sja1000_is_absent(priv)) {
> 
>                  ...
> 
>          }
> 
> 
> 
> What do you think?

The status variable is retrieved from the sja1000 register anyway and sits in
the CPU register.

Checking the status against 0xFF already hints to several problems (bus-off
together with overrun, etc. ) which are unusual in normal operation.
Only in this unusual cased the sja1000_is_absent() is invoked.

This is pretty optimal.

Accessing priv->hotpluggable needs additional pointer dereferencing which is
more costly than accessing/checking the already retrieved status variable.

Best regards,
Oliver

