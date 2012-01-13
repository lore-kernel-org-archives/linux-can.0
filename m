From: Felix Obenhuber <felix@obenhuber.de>
Subject: Re: loopback/recv own messages option not working as expected with
 plx_pci (Adlink Technology PCI-7841)
Date: Fri, 13 Jan 2012 11:30:15 +0100
Message-ID: <CAJsOQGMybFjv8bqknjEbFmj4mBB-VWQEbuQDZxS0hUF-Trfwcg@mail.gmail.com>
References: <CAJsOQGNE959CjAJUCQzxqh_zyrLj-Ed=-RDYBvJq9OrtScMkKw@mail.gmail.com>
	<4F0F1109.6090300@hartkopp.net>
	<CAJsOQGMFQsgy3LGGUDjUE7Jhpr8Jv+Voa_+z0hjezh5usibDew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:63627 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625Ab2AMKaQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Jan 2012 05:30:16 -0500
Received: by werb13 with SMTP id b13so254907wer.19
        for <linux-can@vger.kernel.org>; Fri, 13 Jan 2012 02:30:15 -0800 (PST)
In-Reply-To: <CAJsOQGMFQsgy3LGGUDjUE7Jhpr8Jv+Voa_+z0hjezh5usibDew@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

> I'll try a different kernel on the box that is not working.

I updated to the stock ubuntu kernel

3.0.0-15-generic #25-Ubuntu SMP

The loopback option works as expected.

Felix
