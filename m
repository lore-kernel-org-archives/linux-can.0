From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v4.3] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 cards
Date: Thu, 02 Feb 2012 19:03:21 +0100
Message-ID: <4F2ACFE9.3080602@hartkopp.net>
References: <1328188792-2982-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:48573 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932505Ab2BBSDj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2012 13:03:39 -0500
In-Reply-To: <1328188792-2982-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Hello Stephane et.al.

On 02.02.2012 14:19, Stephane Grosjean wrote:

>  
>  config CAN_PEAK_PCI
> -	tristate "PEAK PCAN PCI/PCIe Cards"
> +	tristate "PEAK PCAN-PCI/PCIe/PCIeC/miniPCI Cards"
>  	depends on PCI
>  	---help---
> -	  This driver is for the PCAN PCI/PCIe cards (1, 2, 3 or 4 channels)
> -	  from PEAK Systems (http://www.peak-system.com).
> +	  This driver is for the PCAN-PCI/PCIe/PCIeC/miniPCI cards
> +	  (1, 2, 3 or 4 channels) from PEAK-System Technik
> +	  (http://www.peak-system.com).
> +
> +	  The I2C bit-banging algorithm should be selected to enable
> +	  correct LEDs management on the PCAN-ExpressCard (PCIeC) card.


The problem is that the PCAN-ExpressCards without galvanic isolation
(IPEH-003000, IPEH-003001) are not working at all when the I2C stuff is not
initialized.

It's not only the LED handling.

What about this:

 config CAN_PEAK_PCI
	tristate "PEAK PCAN-PCI/PCIe/miniPCI Cards"
	depends on PCI
	---help---
	  This driver is for the PCAN PCI/PCIe cards (1, 2, 3 or 4 channels)
	  from PEAK Systems (http://www.peak-system.com).
	  This driver is for the PCAN-PCI/PCIe/PCIeC/miniPCI cards
	  (1, 2, 3 or 4 channels) from PEAK-System Technik
	  (http://www.peak-system.com).

	  The I2C bit-banging algorithm (I2C ALGOBIT) needs to be selected to
	  support PCAN-ExpressCard (PCIeC) cards.

 config CAN_PEAK_PCIEC
	tristate "PEAK PCAN-Express Cards"
	depends on CAN_PEAK_PCI && CONFIG_I2C_ALGOBIT
	---help---
	  (bla bla)

(..)


>  
>  MODULE_DEVICE_TABLE(pci, peak_pci_tbl);
>  
> +#if defined(CONFIG_I2C_ALGOBIT) || defined(CONFIG_I2C_ALGOBIT_MODULE)


#ifdef CONFIG_CAN_PEAK_PCIEC

(..)

Regards,
Oliver
