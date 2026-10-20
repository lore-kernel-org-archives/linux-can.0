Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792461572;
	b=ExVbR1Y5wyfCWhjclZTbBkqMdfuyVFOqy7wJnKbuts+WvjKeBzaW3otkwRKWtbcNVB9z
	 IboGpIBMtv8UDkoO+jxUjFITUTzLmvroQ1IeEPbAWjH9KUHw9U0RjFTY56TE1vxRawDhb
	 mTx3ncKxZ8Huf/rOCSIrHboH8TeCoFygXQiXC+H9Zt6mOvAZxiHgUrc34ZrAsGfyNphYA
	 fWZ+QtSc6mWDgjFIZAnbHyW9mEoWoTa5kHhmea0ljDeF4MTAQg3w/GfEUvSpFRzLnpd1e
	 feJv/rl3SZcilSAe2pGtq4tcTAoMCR5xxuPicvEY2ytvokbl9H2mYrlox7tpI7U+Udg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792461572;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Reply-To:Message-ID:Subject:X-Mailer:MIME-Version:
	 x-aliyun-im-through:References:x-aliyun-mail-creator:In-Reply-To:
	 x-aliyun-mailtrack:Content-Type:Content-Transfer-Encoding;
	bh=Y9GqRZMOhEmyaunPLV07nyz61nY08XdqoGvFsPJGpTs=;
	b=piIwq4Phk1JFenr1IG1IvnoBH/uoS9HBsTDe5L5+eEnsoQhAos/oVfz1RobJIJzEKMXw
	 9GBkxLdE3uqNFXg+4/a8AlyywdLdar69l5xRclvIKVos7vzp6peaPjVjQzTxzCcmoCRAw
	 g/syXKem3RDh4U1rPi+ZdNICRvJdNQouK6zLpiiIbVm411LAwS2vhvHW54bUbrdnW1jd+
	 nCBhBY1tMxx1wEfUc0D5ht9cdSIHG7RB6bB7+djDY0ZcE6DrjCxqyTB6LYh4nxj8R0o9d
	 DGWMMwdO0G+hZzMQxKeFREKvKAEC3sz33XkBFzFMabsB7qHRrcx3M6vKlIanCcd6olA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=VqoV9gwx;
	arc=none smtp.remote-ip=115.124.28.1
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6B8606A31B;
	Tue, 20 Oct 2026 01:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D6B8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=VqoV9gwx
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1792461561; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=Y9GqRZMOhEmyaunPLV07nyz61nY08XdqoGvFsPJGpTs=;
	b=VqoV9gwx6OYfcEeEvdTj/G+iYx0Gu1LqY5exsI08DHrGdudfuC+aYQtzsK+pJ6D7E79zhKWo/WJOHS9oB4XcdRJEpP1iWPOoQyLdP1xPebF3Xd0NhK4CyTFg7wvNJBYSL6+apif2dxAxg+S9aVpUhIBWgkaPu3rJrDvlSy5qE/TU91vh/+QNZnj+dzJEYrfLXvPHhRAXNT50U0xTIkFhVkSpVDi6TS+iBP4uK/sIWb1xg3lJQLl8PZedx97Zw9V0enTlx7fwWoD8ZUlG8NRm/aqbz1qN6wyc03ogr9h0oR6cpvIb+Jdm8CEKf5jerhj1js1YDGWRunm6r8PNP5HHnA==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1739379|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.687584-0.00403358-0.308383;FP=16199972983251956156|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DW;RN=7;RT=7;SR=0;TI=W4_0.2.3_2125197E_1792461313123_o7001c888;
Received: from WS-web (chunyuzhiqiang@yinhe.ht[W4_0.2.3_2125197E_1792461313123_o7001c888] cluster:ay29) at Tue, 20 Oct 2026 09:59:16 +0800
Date: Tue, 20 Oct 2026 09:59:16 +0800
From: "=?UTF-8?B?5rez5LqO5pm65by6?=" <chunyuzhiqiang@yinhe.ht>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "linux-can" <linux-can@vger.kernel.org>,
  "mkl" <mkl@pengutronix.de>,
  "netdev" <netdev@vger.kernel.org>,
  "kernel" <kernel@pengutronix.de>,
  "stable" <stable@vger.kernel.or>,
  "shawnguo" <shawnguo@kernel.org>,
  "imx" <imx@lists.linux.dev>
Reply-To: "=?UTF-8?B?5rez5LqO5pm65by6?=" <chunyuzhiqiang@yinhe.ht>
Message-ID: <294fac9a-da73-4584-92a0-2a1618b10202.chunyuzhiqiang@yinhe.ht>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIG5ldCB2NF0gY2FuOiBkZXY6IGNhbl9maWxsX2luZm8oKTogZG9u?=
  =?UTF-8?B?J3Qgd2FrZSB1cCBjb250cm9sbGVyIGlmIGludGVyZmFjZSBpcyBkb3du?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][null][Chrome]
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20261018101744.93657-1-chunyuzhiqiang@yinhe.ht> <179240547538.3135.2010975389384383545@kernel.org>,<20261019-enchanted-garnet-teal-bc6dad-mkl@pengutronix.de>
x-aliyun-mail-creator: W4_0.2.3_null_QuNTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgNi4xOyBXT1c2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwOS4wLjU0MTQuMTIwIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4xLjAtUmVsZWFzZS42MDIxMTAxKSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAyMTAwIChMaW51eDYuMTIuMTAwK2RlYjEzLWFtZDY0OC4xLjAtUmVsZWFzZS42MDIxMTAxKQ==uM
In-Reply-To: <20261019-enchanted-garnet-teal-bc6dad-mkl@pengutronix.de>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGkgTWFyYywKCj4gQ2FuIHlvdSBhZGQgdGhlIHNhbWUgZm9yIGJvdGggSUZMQV9DQU5fVERDIGFu
ZCBJRkxBX0NBTl9YTF9UREMuCj4KPiBNYXJjCgpZZXMsIHdpbGwgZG8uIHYyIGdhdGVzIGNhbl90
ZGNfZmlsbF9pbmZvKCkgb24gbmV0aWZfcnVubmluZygpIGZvciBib3RoCklGTEFfQ0FOX1REQyBh
bmQgSUZMQV9DQU5fWExfVERDLCBhbmQga2VlcHMgY2FuX2dldF9zaXplKCkgY29uc2lzdGVudC4K
Cj4gW1NldmVyaXR5OiBMb3ddCj4gVGhpcyBhbHNvIGNoYW5nZXMgd2hhdCB1c2Vyc3BhY2Ugc2Vl
cyBmb3IgZXZlcnkgZHJpdmVyIHRoYXQgaW1wbGVtZW50cwo+IGRvX2dldF9iZXJyX2NvdW50ZXIo
KS4gVG9nZXRoZXIgd2l0aCB0aGUgbWF0Y2hpbmcgY2hhbmdlIGluIGNhbl9nZXRfc2l6ZSgpLAo+
IElGTEFfQ0FOX0JFUlJfQ09VTlRFUiBpcyBub3cgbGVmdCBvdXQgb2YgUlRNX0dFVExJTksgYW5k
IFJUTV9ORVdMSU5LCj4gbWVzc2FnZXMgd2hlbmV2ZXIgdGhlIGludGVyZmFjZSBpcyBkb3duLiBB
cyBhIHJlc3VsdCwgImlwIC1kZXRhaWxzIGxpbmsKPiBzaG93IiBubyBsb25nZXIgcHJpbnRzIGJl
cnItY291bnRlciBmb3IgYSBkb3duIGludGVyZmFjZS4KPgo+IEJlZm9yZSB0aGlzIHBhdGNoIHRo
ZSBhdHRyaWJ1dGUgd2FzIGFsd2F5cyBwcmVzZW50Ogo+Cj4gLSBmbGV4Y2FuLCB4aWxpbnhfY2Fu
IGFuZCBjX2NhbiB3b2tlIHRoZSBkZXZpY2UgYW5kIHJlcG9ydGVkIHRoZSByZWFsCj4gICBjb3Vu
dGVycy4KPiAtIG1fY2FuX2dldF9iZXJyX2NvdW50ZXIoKSBhbmQgbWNwMjUxeGZkX2dldF9iZXJy
X2NvdW50ZXIoKSByZXR1cm5lZCAwIHdpdGgKPiAgIHplcm9lZCBjb3VudGVycyB3aGVuIHRoZSBp
bnRlcmZhY2Ugd2FzIG5vdCB1cDoKPgo+IFRoZSBuZXRsaW5rIHBhdGggY2FuIG5vIGxvbmdlciBy
ZWFjaCB0aGVzZSBkcml2ZXItbGV2ZWwgSUZGX1VQIGNoZWNrcy4KPgo+IFRoZSBjb21taXQgbmFt
ZWQgaW4gRml4ZXM6LCBlYzU2YWNmZWYyYWYxLCB3YXMgYWRkZWQgc28gdGhhdCB1c2Vyc3BhY2Ug
Y291bGQKPiBjYWxsIGZsZXhjYW5fZ2V0X2JlcnJfY291bnRlcigpIGV2ZW4gd2hpbGUgdGhlIGlu
dGVyZmFjZSB3YXMgZG93bi4gVGhpcwo+IHBhdGNoIHJldmVyc2VzIHRoYXQgYmVoYXZpb3VyIHJh
dGhlciB0aGFuIGZpeGluZyBhIGRlZmVjdCBpbiBpdCwgYW5kIGl0IGlzCj4gdGFnZ2VkIGZvciBz
dGFibGUuCj4KPiBDb3VsZCB0aGUgY29tbWl0IG1lc3NhZ2Ugc2F5IHRoYXQgSUZMQV9DQU5fQkVS
Ul9DT1VOVEVSIGlzIG5vIGxvbmdlcgo+IHJlcG9ydGVkIGZvciBkb3duIGludGVyZmFjZXMsIGFu
ZCBleHBsYWluIHdoeSB0aGF0IGNoYW5nZSBpcyBhY2NlcHRhYmxlIGZvcgo+IHN0YWJsZT8KClRo
aXMgaXMgYSByZWFsIGFuZCBpbnRlbnRpb25hbCB1c2Vyc3BhY2UtdmlzaWJsZSBjaGFuZ2UsIGFu
ZCBJIHdpbGwgbWFrZSBpdApleHBsaWNpdCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuCgpUaGUgcmVh
c29uIGZvciBvbWl0dGluZyBJRkxBX0NBTl9CRVJSX0NPVU5URVIgd2hpbGUgdGhlIGludGVyZmFj
ZSBpcyBkb3duIGlzCnRoYXQgdGhlIGNvdW50ZXJzIGFyZSBub3QgbWVhbmluZ2Z1bCBpbiB0aGF0
IHN0YXRlLCBhbmQgY2FsbGluZyBpbnRvIHRoZQpkcml2ZXIgY2FuIHdha2UgYSBydW50aW1lLXN1
c3BlbmRlZCBjb250cm9sbGVyIG9yIHRvdWNoIHJlZ2lzdGVycyB3aG9zZQpjbG9ja3MgYXJlIGdh
dGVkLiBUaGUgc2FtZSBjb25jZXJuIGFwcGxpZXMgdG8gdGhlIFREQyBhdXRvIHJlYWRiYWNrIHBh
dGgsCndoaWNoIGlzIHdoeSB2MiBhbHNvIGdhdGVzIElGTEFfQ0FOX1REQyBhbmQgSUZMQV9DQU5f
WExfVERDIG9uCm5ldGlmX3J1bm5pbmcoKS4KCkkgYWdyZWUgdGhhdCB0aGlzIHN1cGVyc2VkZXMg
dGhlIGJlaGF2aW91ciBpbnRyb2R1Y2VkIGJ5IGVjNTZhY2ZlZjJhZjEKcmF0aGVyIHRoYW4gZml4
aW5nIGEgZGVmZWN0IGluIGl0LiB2MiB3aWxsIGRlc2NyaWJlIGl0IHRoYXQgd2F5OiBkb3duCmlu
dGVyZmFjZXMgbm8gbG9uZ2VyIHJlcG9ydCBiZXJyLWNvdW50ZXIsIHVzZXJzcGFjZSBtdXN0IHRy
ZWF0IHRoZSBhdHRyaWJ1dGUKYXMgb3B0aW9uYWwsIGFuZCB0aGUgY2hhbmdlIGlzIGFjY2VwdGFi
bGUgZm9yIHN0YWJsZSBiZWNhdXNlIGl0IGF2b2lkcwpoYXJkd2FyZSBhY2Nlc3MgaW4gdGhlIGRv
d24gc3RhdGUuIEkgd2lsbCBhbHNvIHJld29yZCB0aGUgRml4ZXM6IHRhZyBzbyBpdApkb2VzIG5v
dCBpbXBseSB0aGF0IGVjNTZhY2ZlZjJhZjEgaXRzZWxmIHdhcyBidWdneS4KCnB3LWJvdDogY3I=
