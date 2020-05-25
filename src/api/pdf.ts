import puppeteer from 'puppeteer';

export default async function printPDF(html: string) {
  // launch puppeteer headless browser
  const browser = await puppeteer.launch({
    headless: true,
    args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-dev-shm-usage']
  });
  // load a new page
  const page: puppeteer.Page = await browser.newPage();
  // set the content of the new page with the html included
  await page.setContent(html, { waitUntil: 'networkidle0' });
  // prints letter size documents and collects it back as a buffer
  const pdf: Buffer = await page.pdf({ format: 'Letter' });
  // close the browser
  await browser.close();
  // send the pdf buffer back to the calling function
  return pdf;
};
