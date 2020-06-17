From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939: /proc/net/can interface
Date: Wed, 17 Jun 2020 14:59:49 +0200
Message-ID: <20200617125949.GA12583@x1.vandijck-laurijssen.be>
References: <4SjA_8nFwOgutMJ5YoVaQPwX-zU-3shqgm7lsWxNWIQas0hIsCMdujJJbEJXOdxFjnDlDTqaDs4yiOXhAgZUYDUKIHXKcwtih3aa1fL8LV4=@pm.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:39338 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFQNAF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Jun 2020 09:00:05 -0400
Content-Disposition: inline
In-Reply-To: <4SjA_8nFwOgutMJ5YoVaQPwX-zU-3shqgm7lsWxNWIQas0hIsCMdujJJbEJXOdxFjnDlDTqaDs4yiOXhAgZUYDUKIHXKcwtih3aa1fL8LV4=@pm.me>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Arnej Duranovic <arnejduranovic@pm.me>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello,


On di, 16 jun 2020 18:40:49 +0000, Arnej Duranovic wrote:
> Hello all,
> 
> Earlier versions of J1939 contained the following:
> 
> + 6. /proc/net/can-j1939 Interface.
> + --------------------------------
> +
> +   Files giving you a view on the in-kernel operation of J1939 are located at:
> +   /proc/net/j1939.
> +
> + 6.1 /proc/net/can-j1939/ecu
> +
> +   This file gives an overview of the known ECU's to the kernel.
> +   - iface : network interface they operate on.
> +   - SA : current address.
> +   - name : 64bit NAME
> +   - flags : 'L' = local, 'R' = remote
> 
> I am interested in what happened to this feature since I do not see it in the latest implementation or in the documentation?

The feature got removed, as (almost) all of the /proc interface
for making mainline integration easier.
The idea was to restore the required interfaces when necessary.

> 
> I am interested in retrieving "known ECU's to the kernel" in the latest implementation. What is recommended?

I understand your question. The simple answer right now is: there isn't.

we could debate about this being necessary in /proc,
or rather in debugfs,
since this knowledge should not be used in real applications?
Am I right that your intended use is debugging related?

Kind regards,
Kurt
