From: Stefan May <stefan.may@desy.de>
Subject: Re: CAN Bus over TCP/IP
Date: Wed, 18 Jun 2014 10:52:25 +0200
Message-ID: <1403081545.2708.12.camel@mpslxmarvin>
References: <20140614015522.GC9911@griso.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp-o-3.desy.de ([131.169.56.156]:36415 "EHLO smtp-o-3.desy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965238AbaFRI7u (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 18 Jun 2014 04:59:50 -0400
Received: from smtp-map-3.desy.de (smtp-map-3.desy.de [131.169.56.68])
	by smtp-o-3.desy.de (DESY-O-3) with ESMTP id 40B642808BF
	for <linux-can@vger.kernel.org>; Wed, 18 Jun 2014 10:52:32 +0200 (CEST)
Received: from ZITSWEEP4.win.desy.de (zitsweep4.win.desy.de [131.169.97.98])
	by smtp-map-3.desy.de (DESY_MAP_3) with ESMTP id 34A7F1117
	for <linux-can@vger.kernel.org>; Wed, 18 Jun 2014 10:52:31 +0200 (MEST)
In-Reply-To: <20140614015522.GC9911@griso.site>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Whitmore <arigead@gmail.com>
Cc: linux-can@vger.kernel.org

A very simple solution using a messaging broker is this one:

  https://github.com/smay4finger/MQTT2CAN

Beware, it's not real-time capable and was not developed with network
security in mind.

mfg, Stefan.

On Sa, 2014-06-14 at 02:55 +0100, John Whitmore wrote:
> Was contemplating something which would allow me to transmit CAN Bus frames
> over TCP/IP. Searching throws up a few papers on the subject but wondered if
> there's an OpenSource implementation already out there or any kind of spec on
> the subject. Thought there might be an RFC on the subject but haven't thrown
> up anything.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


