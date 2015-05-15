From: =?UTF-8?B?RnJhbsOnb2lzIEJlYXVsaWVy?= <fbeaulier@orange.fr>
Subject: Linux board with 10 CANs
Date: Fri, 15 May 2015 09:56:19 +0200
Message-ID: <5555A6A3.7090206@orange.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:24831 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933435AbbEOIDx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 15 May 2015 04:03:53 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

I'm starting the design of a CPU board, based on a computer on module 
with a very common SOC like i.mx6 or am335x.
I need to fit my board with at least 10 CAN ports, may be more. (The SOC 
have 2 CANs so i need 8 more)
The board will run with Linux and of course i want a socketcan interface 
for each bus !
CAN bitrate needed is quite low (50kbps) and latency is not critical but 
bus load may reach 100% sometimes.
As far as possible i want to avoid driver development, or just doing 
slight modifications on an existing driver.
I don't want to use MCP2515, i had trouble with it on a previous design 
because of the lack of buffer in the chip.
I can't imagine putting 8 MCP2515 and not missing any frame, but may be 
i'm wrong ?

Here are the options i have considered, they involve using external MCUs 
to provide enough CAN interfaces :

- MCUs with SLCAN : SLCAN have the advantage of simplicity and it should 
offer enough performance at low data rate. Problem is that it would 
require 8 UARTS. I could modify SLCAN driver to allow multiple CAN 
channels on the same UART, and so use MCUs with multiple CANs, does it 
sounds reasonable ?

- MCUs with SPI 1 : adapt MCP2515 driver in a way to make the SPI 
protocol manageable on the MCU side (SPI slave). The MCU will be able to 
provide the buffer for CAN frames that the MCP does not have. This 
option is just a way of trying to go fast, it is not very elegant, and 
have the limitation of one CAN channel per SPI connection / driver instance.

- MCUs with SPI 2 : use the Stefano Babic SPI driver posted on this 
list. This is probably the best choice for a long term and more generic 
solution. But i'm afraid it may require too much work to complete. What 
is the status of this driver right now ? Does anyone have an idea of the 
remaining work to do to make it ready for mainline ? Stefano are you 
available to spend more time on it ? I'm also wondering whether multiple 
instances of the driver can run concurently if i put more than one MCU ?

Concerning the MCU software i could release it as an open-source 
project, anyone interested in participating ?
I'm very familiar with STM32 MCUs so i will probably use an STM32F072 
(low cost cortex M0 with one CAN).

Any idea or advice is welcome, thank you for reading this much too long 
post.

Regards

Francois Beaulier
www.ingelibre.fr
