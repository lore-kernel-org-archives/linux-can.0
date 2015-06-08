From: Armin Burchardt <armin@uni-bremen.de>
Subject: Re: slcand in init.d-scripts
Date: Mon, 08 Jun 2015 12:40:24 +0000
Message-ID: <20150608124024.Horde.GgZbdsMX9MAKdGNjNxHmTFb@webmail.uni-bremen.de>
References: <20150608101412.Horde.cpWZ5_FJEM-ciNcxvoY5Nkf@webmail.uni-bremen.de>
 <55757150.7020008@hartkopp.net> <557587A3.6050209@melag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gabriel-3.zfn.uni-bremen.de ([134.102.50.3]:51837 "EHLO
	smtp.uni-bremen.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752013AbbFHMk0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Jun 2015 08:40:26 -0400
In-Reply-To: <557587A3.6050209@melag.de>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Enrico Weigelt, metux IT consult" <weigelt@melag.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi,

> maybe you could also add an compile-time option to opt-out from
> this code, so we can save a few bits in embedded environments
> if we dont need it.

opt-out from what? Writing the pidfile and setting the UP-flag
is already optional in the patches.

> I, personally, prefer starting such services via some service
> monitor (sometimes even an simply inittab entry is enought).

There is still the -F option to keep slcand from forking.

Regards
Armin

