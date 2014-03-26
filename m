From: Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH v2 1/3] Add documentation for SPI to CAN driver
Date: Wed, 26 Mar 2014 09:07:00 +0100
Message-ID: <53328AA4.9070507@denx.de>
References: <1395757822-22283-1-git-send-email-sbabic@denx.de> <1395757822-22283-2-git-send-email-sbabic@denx.de> <5331C773.9070505@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:43671 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbaCZIHF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Mar 2014 04:07:05 -0400
In-Reply-To: <5331C773.9070505@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: Stefano Babic <sbabic@denx.de>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

Hi Oliver,

On 25/03/2014 19:14, Oliver Hartkopp wrote:
> Please check the patch with checkpatch.pl ...
> 
> There are thousands of lines > 80 chars :-)
> 

Well, checkpatch ran over the patches:

scripts/checkpatch.pl 0001-Add-documentation-for-SPI-to-CAN-driver.patch
total: 0 errors, 0 warnings, 707 lines checked

0001-Add-documentation-for-SPI-to-CAN-driver.patch has no obvious style
problems and is ready for submission.

Anyway, the patch contains tons of long lines. I will check tjem
manually before submitting and fix them.

Best regards,
Stefano Babic


-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
