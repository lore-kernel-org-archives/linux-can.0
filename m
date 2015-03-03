From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Bug on configure ... where to report?
Date: Tue, 03 Mar 2015 07:12:42 +0100
Message-ID: <54F550DA.3010601@hartkopp.net>
References: <54EE63C5.3040307@allcaps.org> <54EEDD2F.5080501@pengutronix.de> <54F4EAE3.5090406@allcaps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:41505 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbCCGMx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Mar 2015 01:12:53 -0500
In-Reply-To: <54F4EAE3.5090406@allcaps.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andrew Lentvorski <bsder@allcaps.org>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 03/02/2015 11:57 PM, Andrew Lentvorski wrote:

> Tried the patch but got this (what am I missing to apply this?):
> 
> root@beaglebone:~/can-utils# git apply makefile-patch.diff
> fatal: patch with only garbage at line 5
> 
> root@beaglebone:~/can-utils# patch <makefile-patch.diff
> patch: **** Only garbage was found in the patch input.
> 
> root@beaglebone:~/can-utils# cat makefile-patch.diff
> diff --git a/GNUmakefile.am b/GNUmakefile.am
> index 53dfb4ec47db..580e60d364c2 100644
> --- a/GNUmakefile.am
> +++ b/GNUmakefile.am
>  <at>  <at>  -1,3 +1,5  <at>  <at>


Your mail client obviously mangled the content :-(

'<at>' has to be '@' of course ...

You may check the content from the mailing list archive:
http://marc.info/?l=linux-can&m=142494031528060&w=2

[Download message RAW] ->

http://marc.info/?l=linux-can&m=142494031528060&q=raw

Just save this link as file and try to apply that file.

cd can-utils
patch -p1 < downloaded.patch

I tested this approach and it worked.

Regards,
Oliver
